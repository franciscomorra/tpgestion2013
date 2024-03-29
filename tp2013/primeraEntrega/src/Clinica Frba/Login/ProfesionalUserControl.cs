﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ClinicaFrba.Comun;
using ClinicaFrba.Negocio;
using ClinicaFrba.Core;
namespace ClinicaFrba.Login
{
    public partial class ProfesionalUserControl : UserControl
    {
        private Profesional _profesional = new Profesional();
        public Profesional GetProfesional()
        {
            var especialidades = clbEspecialidades.CheckedItems.Cast<Especialidad>().ToList();
            if (especialidades.Count == 0)
               throw new Exception("Debe seleccionar al menos una especialidad!");
            if (string.IsNullOrEmpty(txtMatricula.Text.Trim()))
                throw new Exception("La Matricula es obligatoria!");
            _profesional.Matricula = txtMatricula.Text.Trim();
            _profesional.Especialidades = especialidades;
            return _profesional;
        }

        public void SetUser(Profesional profesional)
        {
            _profesional = profesional;
            var especialidadesManager = new EspecialidadesManager();
            List<Especialidad> especialidadesProfesional = especialidadesManager.GetAllForUser(profesional.UserID);
            _profesional.Especialidades = especialidadesProfesional;
            foreach (var especialidad in _profesional.Especialidades)
            {
                clbEspecialidades.SetItemChecked(clbEspecialidades.Items.IndexOf(especialidad), true);
            }
        }

        public ProfesionalUserControl()
        {
            InitializeComponent();
            _profesional = new Profesional();
            var manager = new EspecialidadesManager();
            var especialidades = manager.GetAll();
            clbEspecialidades.Items.Clear();
            especialidades.ForEach(x => clbEspecialidades.Items.Add(x, false));
            clbEspecialidades.DisplayMember = "Nombre";

        }

        private void ProfesionalUserControl_Load(object sender, EventArgs e)
        {

        }
    }
}
