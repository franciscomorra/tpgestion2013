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
    public class RecetasManager
    {
        public void Save(Receta receta)
        {

            SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["StringConexion"].ToString(),
                "[SHARPS].InsertReceta", SqlDataAccessArgs
                .CreateWith(
                    "@BonoFarmacia", receta.BonoFarmacia.Numero)
            .Arguments);
            //Crea una nueva receta, validaciones no son necesarias, se que el bono es bueno, y que el afiliado tambien
            foreach (var medicamento in receta.Medicamentos)
            {

                SqlDataAccess.ExecuteNonQuery(ConfigurationManager.ConnectionStrings["StringConexion"].ToString(),
                    "[SHARPS].AgregarMedicamentos", SqlDataAccessArgs
                    .CreateWith(
                    //Crea nuevas filas en recetas_medicamentos
                        "@BonoFarmacia", receta.BonoFarmacia.Numero)
                        .And("@Medicamento", medicamento.Codigo)
                        .And("@Turno", receta.Turno.Numero)
                .Arguments);
            
            }


        }
    }
}