﻿namespace ClinicaFrba.AbmAfiliado
{
    partial class AfiliadosForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.buttonsPanel = new System.Windows.Forms.Panel();
            this.btnEliminar = new System.Windows.Forms.Button();
            this.btnModificar = new System.Windows.Forms.Button();
            this.btnAgregar = new System.Windows.Forms.Button();
            this.searchPanel = new System.Windows.Forms.Panel();
            this.groupBox = new System.Windows.Forms.GroupBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.txtEmail = new System.Windows.Forms.TextBox();
            this.txtAfiliadoNro = new System.Windows.Forms.TextBox();
            this.txtApellido = new System.Windows.Forms.TextBox();
            this.txtNombre = new System.Windows.Forms.TextBox();
            this.btnLimpiar = new System.Windows.Forms.Button();
            this.btnBuscar = new System.Windows.Forms.Button();
            this.dgvAfiliados = new System.Windows.Forms.DataGridView();
            this.Matricula = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Nombre = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.buttonsPanel.SuspendLayout();
            this.searchPanel.SuspendLayout();
            this.groupBox.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAfiliados)).BeginInit();
            this.SuspendLayout();
            // 
            // buttonsPanel
            // 
            this.buttonsPanel.BackColor = System.Drawing.SystemColors.ActiveBorder;
            this.buttonsPanel.Controls.Add(this.btnEliminar);
            this.buttonsPanel.Controls.Add(this.btnModificar);
            this.buttonsPanel.Controls.Add(this.btnAgregar);
            this.buttonsPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.buttonsPanel.Location = new System.Drawing.Point(0, 0);
            this.buttonsPanel.Name = "buttonsPanel";
            this.buttonsPanel.Size = new System.Drawing.Size(590, 39);
            this.buttonsPanel.TabIndex = 3;
            // 
            // btnEliminar
            // 
            this.btnEliminar.Location = new System.Drawing.Point(174, 10);
            this.btnEliminar.Name = "btnEliminar";
            this.btnEliminar.Size = new System.Drawing.Size(75, 23);
            this.btnEliminar.TabIndex = 2;
            this.btnEliminar.Text = "Eliminar";
            this.btnEliminar.UseVisualStyleBackColor = true;
            this.btnEliminar.Click += new System.EventHandler(this.btnEliminar_Click);
            // 
            // btnModificar
            // 
            this.btnModificar.Location = new System.Drawing.Point(93, 10);
            this.btnModificar.Name = "btnModificar";
            this.btnModificar.Size = new System.Drawing.Size(75, 23);
            this.btnModificar.TabIndex = 1;
            this.btnModificar.Text = "Modificar";
            this.btnModificar.UseVisualStyleBackColor = true;
            this.btnModificar.Click += new System.EventHandler(this.btnModificar_Click);
            // 
            // btnAgregar
            // 
            this.btnAgregar.Location = new System.Drawing.Point(12, 10);
            this.btnAgregar.Name = "btnAgregar";
            this.btnAgregar.Size = new System.Drawing.Size(75, 23);
            this.btnAgregar.TabIndex = 0;
            this.btnAgregar.Text = "Nuevo";
            this.btnAgregar.UseVisualStyleBackColor = true;
            this.btnAgregar.Click += new System.EventHandler(this.btnAgregar_Click);
            // 
            // searchPanel
            // 
            this.searchPanel.Controls.Add(this.groupBox);
            this.searchPanel.Controls.Add(this.btnLimpiar);
            this.searchPanel.Controls.Add(this.btnBuscar);
            this.searchPanel.Dock = System.Windows.Forms.DockStyle.Top;
            this.searchPanel.Location = new System.Drawing.Point(0, 39);
            this.searchPanel.Name = "searchPanel";
            this.searchPanel.Size = new System.Drawing.Size(590, 117);
            this.searchPanel.TabIndex = 5;
            // 
            // groupBox
            // 
            this.groupBox.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.groupBox.Controls.Add(this.label4);
            this.groupBox.Controls.Add(this.label3);
            this.groupBox.Controls.Add(this.label2);
            this.groupBox.Controls.Add(this.label1);
            this.groupBox.Controls.Add(this.txtEmail);
            this.groupBox.Controls.Add(this.txtAfiliadoNro);
            this.groupBox.Controls.Add(this.txtApellido);
            this.groupBox.Controls.Add(this.txtNombre);
            this.groupBox.Location = new System.Drawing.Point(12, 6);
            this.groupBox.Name = "groupBox";
            this.groupBox.Size = new System.Drawing.Size(566, 76);
            this.groupBox.TabIndex = 2;
            this.groupBox.TabStop = false;
            this.groupBox.Text = "Filtro";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(5, 48);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(44, 13);
            this.label4.TabIndex = 7;
            this.label4.Text = "Apellido";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(5, 22);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(44, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Nombre";
            // 
            // label2
            // 
            this.label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(325, 48);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(32, 13);
            this.label2.TabIndex = 5;
            this.label2.Text = "Email";
            // 
            // label1
            // 
            this.label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(261, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(96, 13);
            this.label1.TabIndex = 4;
            this.label1.Text = "Numero de Afiliado";
            // 
            // txtEmail
            // 
            this.txtEmail.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtEmail.Location = new System.Drawing.Point(363, 45);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.Size = new System.Drawing.Size(197, 20);
            this.txtEmail.TabIndex = 3;
            // 
            // txtAfiliadoNro
            // 
            this.txtAfiliadoNro.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtAfiliadoNro.Location = new System.Drawing.Point(363, 19);
            this.txtAfiliadoNro.Name = "txtAfiliadoNro";
            this.txtAfiliadoNro.Size = new System.Drawing.Size(197, 20);
            this.txtAfiliadoNro.TabIndex = 2;
            // 
            // txtApellido
            // 
            this.txtApellido.Location = new System.Drawing.Point(55, 45);
            this.txtApellido.Name = "txtApellido";
            this.txtApellido.Size = new System.Drawing.Size(197, 20);
            this.txtApellido.TabIndex = 1;
            // 
            // txtNombre
            // 
            this.txtNombre.Location = new System.Drawing.Point(55, 19);
            this.txtNombre.Name = "txtNombre";
            this.txtNombre.Size = new System.Drawing.Size(197, 20);
            this.txtNombre.TabIndex = 0;
            // 
            // btnLimpiar
            // 
            this.btnLimpiar.Location = new System.Drawing.Point(12, 88);
            this.btnLimpiar.Name = "btnLimpiar";
            this.btnLimpiar.Size = new System.Drawing.Size(75, 23);
            this.btnLimpiar.TabIndex = 1;
            this.btnLimpiar.Text = "Limpiar";
            this.btnLimpiar.UseVisualStyleBackColor = true;
            this.btnLimpiar.Click += new System.EventHandler(this.btnLimpiar_Click);
            // 
            // btnBuscar
            // 
            this.btnBuscar.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnBuscar.Location = new System.Drawing.Point(503, 88);
            this.btnBuscar.Name = "btnBuscar";
            this.btnBuscar.Size = new System.Drawing.Size(75, 23);
            this.btnBuscar.TabIndex = 0;
            this.btnBuscar.Text = "Filtrar";
            this.btnBuscar.UseVisualStyleBackColor = true;
            this.btnBuscar.Click += new System.EventHandler(this.btnBuscar_Click);
            // 
            // dgvAfiliados
            // 
            this.dgvAfiliados.AllowUserToAddRows = false;
            this.dgvAfiliados.AllowUserToDeleteRows = false;
            this.dgvAfiliados.AllowUserToOrderColumns = true;
            this.dgvAfiliados.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvAfiliados.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvAfiliados.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Matricula,
            this.Nombre});
            this.dgvAfiliados.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgvAfiliados.Location = new System.Drawing.Point(0, 156);
            this.dgvAfiliados.MultiSelect = false;
            this.dgvAfiliados.Name = "dgvAfiliados";
            this.dgvAfiliados.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvAfiliados.Size = new System.Drawing.Size(590, 314);
            this.dgvAfiliados.TabIndex = 7;
            // 
            // Matricula
            // 
            this.Matricula.DataPropertyName = "NroAfiliado";
            this.Matricula.HeaderText = "Numero de Afiliado";
            this.Matricula.Name = "Matricula";
            this.Matricula.ReadOnly = true;
            // 
            // Nombre
            // 
            this.Nombre.DataPropertyName = "DetallesPersona";
            this.Nombre.HeaderText = "Nombre";
            this.Nombre.Name = "Nombre";
            this.Nombre.ReadOnly = true;
            // 
            // AfiliadosForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(590, 470);
            this.Controls.Add(this.dgvAfiliados);
            this.Controls.Add(this.searchPanel);
            this.Controls.Add(this.buttonsPanel);
            this.Name = "AfiliadosForm";
            this.Text = "Administrar Afiliados";
            this.Load += new System.EventHandler(this.AfiliadosForm_Load);
            this.buttonsPanel.ResumeLayout(false);
            this.searchPanel.ResumeLayout(false);
            this.groupBox.ResumeLayout(false);
            this.groupBox.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dgvAfiliados)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel buttonsPanel;
        private System.Windows.Forms.Button btnEliminar;
        private System.Windows.Forms.Button btnModificar;
        private System.Windows.Forms.Button btnAgregar;
        private System.Windows.Forms.Panel searchPanel;
        private System.Windows.Forms.GroupBox groupBox;
        private System.Windows.Forms.Button btnLimpiar;
        private System.Windows.Forms.Button btnBuscar;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox txtEmail;
        private System.Windows.Forms.TextBox txtAfiliadoNro;
        private System.Windows.Forms.TextBox txtApellido;
        private System.Windows.Forms.TextBox txtNombre;
        private System.Windows.Forms.DataGridView dgvAfiliados;
        private System.Windows.Forms.DataGridViewTextBoxColumn Matricula;
        private System.Windows.Forms.DataGridViewTextBoxColumn Nombre;
    }
}