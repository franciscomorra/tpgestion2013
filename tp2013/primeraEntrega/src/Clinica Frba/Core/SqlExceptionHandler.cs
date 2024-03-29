﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace ClinicaFrba.Core
{
    class SqlExceptionHandler
    {
        public static void Handle(SqlException exception)
        {
            var message = exception.Message.ToUpperInvariant();
            foreach (var key in ConstraintMessages.Keys)
            {
                if (message.Contains(key))
                {
                    MessageBox.Show(ConstraintMessages[key]);
                    return;
                }
            }
            MessageBox.Show(exception.Message);
        }

        private static Dictionary<string, string> ConstraintMessages
        {
            get
            {
                return new Dictionary<string, string>()
                {
                    {"IX_USUARIO", "El nombre de usuario ya existe, seleccione uno nuevo"},
                    {"IX_DETALLEENTIDAD_TELEFONO", "Ya hay un usuario con el mismo teléfono"},
                    //{"IX_PROVEEDOR_Matricula", "Ya hay un profesional con el Matricula especificado"},
                    //{"IX_PROVEEDOR_RSOCIAL", "Ya hay un profesional con esa Razón Social"},
                   // {"CK_CLIENTE_SALDO", "No posee saldo suficiente para realizar la compra"}
                };
            }
        }
    }
}
