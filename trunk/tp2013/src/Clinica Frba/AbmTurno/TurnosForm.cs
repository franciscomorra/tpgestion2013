﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ClinicaFrba.Core;
using ClinicaFrba.Login;
using ClinicaFrba.Comun;
using ClinicaFrba.Negocio;

using ClinicaFrba.AbmAfiliado;
using System.Configuration;


namespace ClinicaFrba.AbmTurno
{
    [PermissionRequired(Functionalities.AdministrarTurnos)]
    public partial class TurnosForm : Form
    {
        private bool _isSearchMode = false;
        public event EventHandler<TurnoSelectedEventArgs> OnTurnoselected;
        private Turno turno = new Turno();
        private TurnosManager _turnosManager = new TurnosManager();
        private Afiliado _afiliado;
        private AfiliadosForm _afiliadosForm;

        public TurnosForm()
        {
            InitializeComponent();
        }
        public void SetSearchMode(Afiliado afiliado)
        {
            _afiliado = afiliado;
            buttonsPanel.Visible = false;
            _isSearchMode = true;
        }

        private void TurnosForm_Load(object sender, EventArgs e)
        {
            panelAfiliado.Visible = true;
            if (Session.User.Perfil.Nombre == "Afiliado" || _afiliado != null)
            {
                if(_afiliado == null)
                    _afiliado = Session.User as Afiliado;
                panelAfiliado.Visible = false;
                var dataSource = _turnosManager.GetAll(_afiliado);
                dgvTurnos.DataSource = dataSource;
            }

        }


        private void btnBuscarAfiliado_Click(object sender, EventArgs e)
        {
            if (_afiliadosForm == null)
            {
                _afiliadosForm = new AfiliadosForm();
                _afiliadosForm.SetSearchMode();
                _afiliadosForm.OnAfiliadoSelected += new EventHandler<AfiliadoSelectedEventArgs>(_afiliadosForm_OnAfiliadoSelected);
            }
            ViewsManager.LoadModal(_afiliadosForm);
        }

        void _afiliadosForm_OnAfiliadoSelected(object sender, AfiliadoSelectedEventArgs e)
        {
            _afiliado = e.Afiliado;
            txtAfiliado.Text = _afiliado.ToString();
            _afiliadosForm.Hide();
            var dataSource = _turnosManager.GetAll(_afiliado);
            dgvTurnos.DataSource = dataSource;

        }


        private void btnAgregar_Click(object sender, EventArgs e)
        {
            var addTurnoForm = new PedirTurnoForm();
            addTurnoForm._afiliado = _afiliado;
            addTurnoForm.OnTurnoUpdated += new EventHandler<TurnoUpdatedEventArgs>(pedirTurnoOnTurnoUpdated);
            ViewsManager.LoadModal(addTurnoForm);
        }

        void pedirTurnoOnTurnoUpdated(object sender, TurnoUpdatedEventArgs e)
        {
            try
            {
                var dataSource = dgvTurnos.DataSource as BindingList<Turno>;
                MessageBox.Show(string.Format("Turno {0} guardado correctamente", e.Turno.Fecha.ToString()));
                dataSource.Add(e.Turno);
                dgvTurnos.Refresh();
            }
            catch (System.Exception excep)
            {
                MessageBox.Show(excep.Message);
            }
        }


        private void btnCancelar_Click(object sender, EventArgs e)
        {
            if (dgvTurnos.SelectedRows == null || dgvTurnos.SelectedRows.Count == 0) return;
            var row = dgvTurnos.SelectedRows[0];
            
            var turno = row.DataBoundItem as Turno;
            
            var pedirTurnoForm = new PedirTurnoForm();
            /*
            addEditForm.Set(rol);
            addEditForm.OnRoleUpdated += new EventHandler<RoleUpdatedEventArgs>(addEditForm_OnRoleUpdated);
            ViewsManager.LoadModal(addEditForm);
*/
        }



        private void dgvTurnos_CellContentDoubleClick(object sender, EventArgs e)
        {
            if (dgvTurnos.SelectedRows == null || dgvTurnos.SelectedRows.Count == 0) return;
            var row = dgvTurnos.SelectedRows[0];
            var turno = row.DataBoundItem as Turno;
            if (OnTurnoselected != null)
            {
                OnTurnoselected(this, new TurnoSelectedEventArgs()
                {
                    Turno = turno
                });
            }
            this.Close();
        }






    }
}