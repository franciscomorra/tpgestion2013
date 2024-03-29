﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using ClinicaFrba.Login;
using ClinicaFrba.Core;
using ClinicaFrba.Negocio;
using ClinicaFrba.Comun;
using System.Security.Cryptography;
using System.Configuration;

namespace ClinicaFrba.Login
{
    [NonNavigable]
    public partial class LoginForm : Form
    {
        User user;
        LoginService svc = new LoginService();
        RolesManager rolManager = new RolesManager();
        DetallePersonaManager detallesManager = new DetallePersonaManager();
        public LoginForm()
        {
            InitializeComponent();
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
           
            try
            {
                Login(txtUserName.Text, txtPassword.Text);
            }
            catch (System.Exception excep)
            {
                MessageBox.Show(excep.Message);
            }
        }

        private void Login(string userName, string pass)
        {
            BindingList<Rol> roles = new BindingList<Rol>();
            try
            {
                user = svc.Login(userName, pass);
                roles = rolManager.GetUserRoles(user.UserID);
                if (roles.Count > 1)
                {
                    comboRoles.DataSource = roles;
                    comboRoles.DisplayMember = "Nombre";
                    comboRoles.SelectedIndex = 0;
                    panelRoles.Show();
                }
                else
                {
                    if (roles.Count < 1)
                        throw new Exception("El usuario no tiene roles asignados, contacte a un administrativo!");
                    Rol rol = (Rol)roles.ElementAt(0);
                    user.RoleID = rol.ID;
                    user.Perfil = rol.Perfil;
                    svc.SetUserFunctionalities(user);
                    user.DetallesPersona = detallesManager.BuscarDetalles(user.UserID);
                    iniciar_sesion();
                }
            }
            catch (System.Exception excep)
            {
                MessageBox.Show(excep.Message);
                return;
            }
        }
        private void iniciar_sesion() {
            try
            {
                svc.SetUserFunctionalities(user);
                Session.StartSession(user);

                ViewsManager.LimpiarVistas();
                if (user.Perfil.Nombre == "Afiliado")
                {
                    
                    var manager = new AfiliadoManager();
                    Afiliado afiliado = manager.actualizarInformacion(user.UserID);
                    Session.Afiliado = afiliado;
                    if (afiliado.FaltanDatos)
                    {
                        MessageBox.Show("Por favor, verifique sus datos a continuacion");
                        var regForm = new RegistroForm();
                        regForm.esNuevoUsuario = false;
                        regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
                        regForm.perfilSeleccionado = "Afiliado";
                        regForm.rellenarAfiliado(afiliado);
                        ViewsManager.LoadModal(regForm);
                    }
                }
                else if (user.Perfil.Nombre == "Profesional")
                {
                    var manager = new ProfesionalManager();
                    Profesional profesional = manager.getInfo(user.UserID);
                    Session.Profesional = profesional;
                    if (profesional.FaltanDatos)
                    {
                        MessageBox.Show("Por favor, verifique sus datos a continuacion");
                        var regForm = new RegistroForm();
                        regForm.esNuevoUsuario = false;
                        regForm.OnUserSaved += new EventHandler<UserSavedEventArgs>(regForm_OnUserSaved);
                        regForm.rellenarProfesional(profesional);
                        regForm.perfilSeleccionado = "Profesional";
                        ViewsManager.LoadModal(regForm);
                    }
                }
            }
            catch (System.Exception excep)
            {
                MessageBox.Show(excep.Message);
            }
        }
        private void btnRol_Click(object sender, EventArgs e)
        {
            Rol rolSelected = (Rol)comboRoles.SelectedItem;
            user.RoleID = rolSelected.ID;
            user.Perfil = rolSelected.Perfil;
            iniciar_sesion();
        }

        void regForm_OnUserSaved(object sender, UserSavedEventArgs e)
        {
            MessageBox.Show("Datos Guardados correctamente para " + e.User.ToString());
        }

    }
}
