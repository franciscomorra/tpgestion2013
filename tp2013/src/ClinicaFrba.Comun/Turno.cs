﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ClinicaFrba.Comun
{
    public class Turno
    {
        public int Numero { get; set; }
        public Profesional Profesional { get; set; }
        public Afiliado Afiliado { get; set; }
        public DateTime Fecha { get; set; }
        public int AgendaID { get; set; }
        public int NroConsulta { get; set; }
        public Especialidad Especialidad { get; set; }
        public override string ToString()
        {
            return Fecha+" ("+Numero+")";
        }
    }
}
