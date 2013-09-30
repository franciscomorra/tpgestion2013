﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Data;
using System.Configuration;
using System.Data;
using ClinicaFrba.Comun;
using System.ComponentModel;

namespace ClinicaFrba.Negocio
{
    public class RolesManager
    {
        /*
        public BindingList<Rol> GetRoles()
         * usa el procedimiento GetRoles de SQL Saca todos los roles
        public void DeleteRole(Rol rol)
         * usa el procedimiento DeleteRole de SQL, borra un rol
        public void SaveRole(Rol rol)
         * ??
        private void InsertRole(Rol rol)
         * usa el procedimiento InsertRole de SQL, requiere el nombre del rol

        private void UpdateRole(Rol rol)


        private void UpdateRoleFunctionalities(Rol rol)


        public int GetDefaultRoleID()
        */
        public BindingList<Rol> GetRoles()
        {
            var result = SqlDataAccess.ExecuteDataTableQuery(
                ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "ClinicaFrba.GetRoles"
            );
            var roles = new BindingList<Rol>();
            var functionalitiesManager = new FunctionalitiesManager();
            foreach (DataRow row in result.Rows)
            {
                var rol = new Rol()
                {
                    ID = int.Parse(row["ID"].ToString()),
                    Nombre = row["Descripcion"].ToString(),
                    Functionalities = functionalitiesManager.GetRoleFunctionalities(int.Parse(row["ID"].ToString()))
                };
                roles.Add(rol);
            }

            return roles;
        }
        public void DeleteRole(Rol rol)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "ClinicaFrba.DeleteRole", SqlDataAccessArgs
                .CreateWith("@Rol_ID", rol.ID)
            .Arguments);
        }

        public void SaveRole(Rol rol)
        {
            if (rol.ID > 0) UpdateRole(rol);
            else InsertRole(rol);
        }

        private void InsertRole(Rol rol)
        {
            var roleId = SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "ClinicaFrba.InsertRole", SqlDataAccessArgs
                .CreateWith("@Description", rol.Nombre)
            .Arguments);
            rol.ID = roleId;
            UpdateRoleFunctionalities(rol);
        }

        private void UpdateRole(Rol rol)
        {
            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "ClinicaFrba.UpdateRole", SqlDataAccessArgs
                .CreateWith("@Description", rol.Nombre)
                .And("@ID", rol.ID)
            .Arguments);

            UpdateRoleFunctionalities(rol);
        }

        private void UpdateRoleFunctionalities(Rol rol)
        {
            var manager = new FunctionalitiesManager();
            if(rol.ID > 0)
                manager.DeleteRoleFunctionalities(rol);
            foreach (var functionality in rol.Functionalities)
            {
                manager.InsertRoleFunctionality(rol, functionality);
            }
        }

        public int GetDefaultRoleID()
        {
            return SqlDataAccess.ExecuteScalarQuery<int>(ConfigurationManager.ConnectionStrings["GrouponConnectionString"].ToString(),
                "ClinicaFrba.GetDefaultRoleID");
        }
    }
}
