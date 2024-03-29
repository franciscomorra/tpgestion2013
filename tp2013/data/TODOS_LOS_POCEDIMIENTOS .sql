USE [GD2C2013]
GO
/****** Object:  StoredProcedure [SHARPS].[NuevoGrupoFamiliar]    Script Date: 11/10/2013 02:23:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[NuevoGrupoFamiliar] 
	@max int
AS
begin
	select @max  = @max + 1
end
GO
/****** Object:  StoredProcedure [SHARPS].[UpdateRole]    Script Date: 11/10/2013 02:23:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[UpdateRole]
	@Description nvarchar(100),
	@ID int
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE SHARPS.Roles SET Descripcion = @Description
	WHERE RolID = @ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[InsertRole]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[InsertRole]
	@Description nvarchar(100),
	@PerfilID int
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO SHARPS.Roles (Descripcion,Perfil) VALUES (@Description,@PerfilID)
	SELECT @@Identity AS ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetUserRoles]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetUserRoles] 
@userID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.RolID as ID, r.Descripcion as Descripcion, r.Perfil as PerfilId, p.Descripcion as PerfilNombre
	FROM  [SHARPS].Roles r
	INNER JOIN [SHARPS].Usuarios_Roles ur ON ur.Rol = r.RolID
	INNER JOIN [SHARPS].Perfiles p on p.PerfilID = r.Perfil
	WHERE ur.usuario = @userID
	ORDER BY r.Descripcion

END
GO
/****** Object:  StoredProcedure [SHARPS].[GetUserLoginAttempts]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetUserLoginAttempts]
	@Nombre nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Intentos FROM  [SHARPS].Usuarios WHERE username = @Nombre
	IF(@@ROWCOUNT = 0)
		SELECT 0 AS Intentos
END
GO

/****** Object:  StoredProcedure [SHARPS].[GetRolesByPerfil]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetRolesByPerfil]
@Perfil nvarchar(max)
AS
BEGIN
	SELECT
		r.RolID,
		r.Descripcion
	FROM  [SHARPS].Roles r
	INNER JOIN [SHARPS].Perfiles p ON r.Perfil = p.PerfilID 
	--WHERE r.Activo = 1
	WHERE p.Descripcion = @Perfil 
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetRoles]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetRoles]

AS
BEGIN
	SELECT
		r.RolID ID,
		r.Descripcion,
		r.Perfil as PerfilID,
		p.Descripcion as PerfilNombre
	FROM  [SHARPS].Roles r
	 JOIN [SHARPS].Perfiles p ON p.PerfilID = r.Perfil
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetRoleFunctionalities]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.Descripcion FROM  [SHARPS].Funcionalidades F
	INNER JOIN [SHARPS].Roles_Funcionalidades RF ON F.Codigo = RF.Funcionalidad
	WHERE RF.Rol = @Rol_ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetPerfilInfo]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetPerfilInfo]
@NombrePerfil varchar(MAX)
AS
BEGIN
	SELECT
		p.PerfilID
	FROM  [SHARPS].Perfiles p
	WHERE p.Descripcion = @NombrePerfil
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetPerfilFunctionalities]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetPerfilFunctionalities]
	@Perfil_ID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.Descripcion FROM  [SHARPS].Funcionalidades F
	INNER JOIN [SHARPS].Perfiles_Funcionalidades PF ON F.Codigo = PF.Funcionalidad
	WHERE PF.Perfil = @Perfil_ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetProfesionales]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetProfesionales]

AS
BEGIN
	SELECT
		u.usuarioID ID,
		u.username UserName,
		p.Matricula Matricula,
		dp.apellido Apellido, 
		dp.nombre Nombre, 
		dp.sexo Sexo, 
		dp.mail Email,
		dp.fechaNac FechaNacimiento, 
		dp.TipoDNI TipoDoc, 
		dp.telefono Telefono, 
		dp.direccion Direccion, 
		dp.dni DNI, 
		p.Faltan_Datos FaltanDatos
	FROM  [SHARPS].USUARIOS u
	INNER JOIN [SHARPS].PROFESIONALES P on p.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	WHERE P.Activo = 1
	ORDER BY U.UsuarioID

END
GO
/****** Object:  StoredProcedure [SHARPS].[GetPlanesMedicos]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetPlanesMedicos]

AS
BEGIN
	SELECT
		pm.Codigo,
		pm.Descripcion,
		pm.Precio_Bono_Consulta,
		pm.Precio_Bono_Farmacia
	FROM  [SHARPS].Planes_Medicos pm
	WHERE pm.Activo = 1
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetPerfiles]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetPerfiles]

AS
BEGIN
	SELECT
		p.PerfilID ID,
		p.Descripcion
	FROM  [SHARPS].Perfiles p
END
GO
/****** Object:  UserDefinedFunction [SHARPS].[GetFunctionalityByName]    Script Date: 11/10/2013 02:23:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SHARPS].[GetFunctionalityByName] 
(
	@Func_Name nvarchar(255)
)
RETURNS int
AS
BEGIN
	DECLARE @Func_ID int

	SELECT @Func_ID = Codigo FROM SHARPS.Funcionalidades
	WHERE Descripcion = @Func_Name

	RETURN @Func_ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetEspecialidadesForUser]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetEspecialidadesForUser]
@userId INT
AS
BEGIN
	SELECT
		e.Codigo ID,
		e.Descripcion
	FROM  [SHARPS].Especialidades e
	INNER JOIN [SHARPS].Profesionales_Especialidades pe ON pe.Especialidad = e.Codigo
	WHERE pe.Profesional= @userId AND E.Activo = 1
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetDetallesPersona]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetDetallesPersona]
@userId INT
AS
BEGIN
	SELECT
		dp.apellido Apellido, 
		dp.nombre Nombre, 
		dp.sexo Sexo, 
		dp.mail Email,
		dp.fechaNac FechaNacimiento, 
		dp.TipoDNI TipoDoc, 
		dp.telefono Telefono, 
		dp.direccion Direccion, 
		dp.dni DNI
	FROM  [SHARPS].DETALLES_PERSONA dp
	WHERE dp.UsuarioID = @userId 
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetBonos]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [SHARPS].[GetAllEspecialidades]
AS
BEGIN
	SELECT
		e.Codigo ID,
		e.Descripcion
	FROM  [SHARPS].Especialidades e
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetAfiliados]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetAfiliados]

AS
BEGIN
	SELECT
		u.usuarioID ID,
		u.username UserName,
		pm.codigo Plan_ID,
		pm.Precio_Bono_Consulta PrecioConsulta, 
		pm.Precio_Bono_Farmacia PrecioFarmacia, 
		a.cantHijos CantHijos,
		a.GrupoFamiliar GrupoFamiliar,
		a.tipoAfiliado TipoAfiliado,
		ec.Descripcion EstadoCivil, 
		dp.apellido Apellido, 
		dp.nombre Nombre, 
		dp.sexo Sexo, 
		dp.mail Email,
		dp.fechaNac FechaNacimiento, 
		dp.TipoDNI TipoDoc, 
		dp.telefono Telefono, 
		dp.direccion Direccion, 
		dp.dni DNI,
		a.Faltan_Datos FaltanDatos
	FROM  [SHARPS].USUARIOS u
	INNER JOIN [SHARPS].AFILIADOS a on a.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].PLANES_MEDICOS pm on pm.codigo = a.Plan_Medico
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].Estados_Civiles ec on ec.Codigo = a.Estado_Civil
    WHERE a.Activo = 1
	ORDER BY U.UsuarioID

END
GO
/****** Object:  StoredProcedure [SHARPS].[GetAfiliadoInfo]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetAfiliadoInfo]
@userId INT
AS
BEGIN
	SELECT
		u.usuarioID ID,
		u.username UserName,
		pm.codigo Plan_ID,
		pm.Precio_Bono_Consulta PrecioConsulta, 
		pm.Precio_Bono_Farmacia PrecioFarmacia, 
		a.cantHijos CantHijos,
		a.GrupoFamiliar GrupoFamiliar,
		a.tipoAfiliado TipoAfiliado,
		ec.Descripcion EstadoCivil, 
		dp.apellido Apellido, 
		dp.nombre Nombre, 
		dp.sexo Sexo, 
		dp.mail Email,
		dp.fechaNac FechaNacimiento, 
		dp.TipoDNI TipoDoc, 
		dp.telefono Telefono, 
		dp.direccion Direccion, 
		dp.dni DNI
	FROM  [SHARPS].USUARIOS u
	INNER JOIN [SHARPS].AFILIADOS a on a.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].PLANES_MEDICOS pm on pm.codigo = a.Plan_Medico
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].Estados_Civiles ec on ec.Codigo = a.Estado_Civil
	WHERE A.UsuarioID = @userId
	ORDER BY U.UsuarioID

END
GO
/****** Object:  StoredProcedure [SHARPS].[DeleteRoleFunctionalities]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[DeleteRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	DELETE FROM SHARPS.Roles_Funcionalidades
	WHERE Rol = @Rol_ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[DeleteRole]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[DeleteRole]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE SHARPS.Roles SET Activo = 0 WHERE RolID = @Rol_ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[ComprarBonoReceta]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [SHARPS].[Login]
	@Nombre nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT UsuarioID as ID, username as Nombre, activo as estado FROM  [SHARPS].Usuarios WHERE
	username = @Nombre AND Password = @Password AND Activo = 1
	
	IF @@ROWCOUNT = 0
		BEGIN
			UPDATE [SHARPS].Usuarios SET Intentos = Intentos + 1
			WHERE username = @Nombre
		END
	ELSE
		BEGIN
			UPDATE [SHARPS].Usuarios SET Intentos = 0
			WHERE username = @Nombre
		END
END
GO
/****** Object:  StoredProcedure [SHARPS].[InsertUser]    Script Date: 11/10/2013 02:23:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[InsertUser]
	@username nvarchar(max),
	@password nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO SHARPS.Usuarios(Username,Password,Intentos,Activo) VALUES (@username,@password,0,1)
	SELECT @@Identity AS ID
END
GO
/****** Object:  StoredProcedure [SHARPS].[InsertSpeciality]    Script Date: 11/10/2013 02:23:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [SHARPS].[InsertRoleFunctionality]
	@Rol_ID int,
	@Funcionalidad nvarchar(255)
AS
BEGIN
	INSERT INTO SHARPS.Roles_Funcionalidades (Rol, Funcionalidad)
	VALUES (@Rol_ID, [SHARPS].[GetFunctionalityByName](@Funcionalidad))
END
GO





CREATE PROCEDURE [SHARPS].[UpdateDetallePersona]

@Telefono numeric (18,0),
@Email varchar(255),
@Nombre varchar(255),
@Apellido varchar(255),
@DNI numeric (18,0),
@TipoDNI varchar(255),
@Sexo char(10),
@FechaNacimiento date,
@Direccion varchar(255),
@ID_Usuario numeric (18,0)

AS
BEGIN

UPDATE [SHARPS].Detalles_Persona SET
telefono = @Telefono , mail = @Email , nombre = @Nombre , apellido = @Apellido , direccion = @Direccion 
, dni = @DNI , TipoDNI = @TipoDNI  , sexo = @Sexo , fechaNac = @FechaNacimiento
WHERE @ID_Usuario = UsuarioID

END
GO


CREATE PROCEDURE [SHARPS].[InsertDetallePersona]

@Telefono numeric (18,0),
@Email varchar(255),
@Nombre varchar(255),
@Apellido varchar(255),
@DNI numeric (18,0),
@TipoDNI varchar(255),
@Sexo char(10),
@FechaNacimiento date,
@Direccion varchar(255),
@ID_Usuario numeric (18,0)

AS
BEGIN
INSERT INTO [SHARPS].Detalles_Persona (telefono ,TipoDNI , sexo, UsuarioID , direccion , apellido , nombre , mail , fechaNac,dni)
VALUES ( @Telefono , @TipoDNI , @Sexo , @ID_Usuario , @Direccion , @Apellido , @Nombre , @Email , @FechaNacimiento , @DNI)

END 
GO





CREATE PROCEDURE [SHARPS].[InsertAfiliado]
@PlanMedico numeric(18,0),
@ID numeric (18,0),
@EstadoCivil nchar(10),
@CantHijos int

AS 
BEGIN  
DECLARE @NroAfiliado int
DECLARE @codCivil int
SELECT @codCivil = Codigo from [SHARPS].Estados_Civiles where Descripcion = @EstadoCivil
SELECT @NroAfiliado = MAX(GrupoFamiliar) + 101 FROM [SHARPS].Afiliados
INSERT INTO [SHARPS].Afiliados (GrupoFamiliar , Plan_Medico , cantHijos , Estado_Civil , UsuarioID,Faltan_Datos)
VALUES (@NroAfiliado , @PlanMedico , @CantHijos ,@codCivil  , @ID,1) 
RETURN @NroAfiliado
END
GO 


CREATE PROCEDURE [SHARPS].[UpdateAfiliado]

@PlanMedico INT,
@ID INT,
@EstadoCivil nchar(10),
@CantHijos int,
@RolAfiliado INT, 
@Motivo char(10)
AS 
BEGIN
UPDATE [SHARPS].Afiliados set Plan_Medico = @PlanMedico , Estado_Civil = @EstadoCivil , cantHijos = @CantHijos , Faltan_Datos = 0
WHERE usuarioId = @ID
INSERT INTO [SHARPS].Cambios_Afiliado(Motivo_Cambio , Fecha , Afiliado)
VALUES (@Motivo , GETDATE() ,@ID )
DELETE SHARPS.Usuarios_Roles WHERE Usuario = @ID AND Rol = @RolAfiliado
INSERT INTO SHARPS.Usuarios_Roles (Usuario , Rol) VALUES (@ID , @RolAfiliado)
END
GO


CREATE PROCEDURE [SHARPS].[InsertMiembroGrupoFamiliar]
@PlanMedico int,
@EstadoCivil int,
@CantHijos int,
@RolAfiliado nvarchar(MAX),
@GrupoFamiliar int,
@TipoAfiliado int,
@UserID int   
AS
BEGIN 


INSERT INTO [SHARPS].Afiliados (GrupoFamiliar , UsuarioID , TipoAfiliado , CantHijos , Activo , Plan_Medico ,Faltan_Datos)
VALUES (@GrupoFamiliar , @UserID , NULL , @CantHijos ,1 , @PlanMedico,1)

DELETE SHARPS.Usuarios_Roles WHERE Usuario = @UserID AND Rol = @RolAfiliado
INSERT INTO [SHARPS].Usuarios_Roles (Usuario, Rol) 
VALUES (@UserID , @RolAfiliado)

UPDATE [SHARPS].Roles SET  Descripcion = 'Afiliado' , Activo = 1, Perfil = 1
WHERE RolID = @RolAfiliado



END
GO


CREATE PROCEDURE [SHARPS].[InsertProfesional]
@Matricula  int,
@ID int,
@Rol int

AS
BEGIN 
INSERT INTO Profesionales (Matricula , Activo , UsuarioID,Faltan_Datos)
VALUES (@Matricula , 1 , @ID,1)

DELETE SHARPS.Usuarios_Roles WHERE Usuario = @ID AND Rol = @Rol
INSERT INTO [SHARPS].Usuarios_Roles (Usuario, Rol) 
VALUES (@ID , @Rol)

UPDATE [SHARPS].Roles SET  Descripcion = 'Profesional' , Activo = 1, Perfil = 2
WHERE RolID = @Rol 

END
GO



CREATE PROCEDURE [SHARPS].[UpdateProfesional]
@Matricula int,
@ID int

AS
BEGIN

UPDATE [SHARPS].Profesionales SET Matricula = @Matricula , Faltan_Datos = 0
WHERE UsuarioID = @ID 

END
GO


CREATE PROCEDURE [SHARPS].[InsertSpeciality]
@MedicoID int,
@Especialidad int

AS
BEGIN
INSERT INTO [SHARPS].Profesionales_Especialidades (Profesional , Especialidad) 
VALUES (@MedicoID , @Especialidad)
END
GO


CREATE PROCEDURE [SHARPS].[CancelarDiaProfesional]
@MedicoID int,
@Fecha date

AS
BEGIN

UPDATE [SHARPS].Turnos
SET Estado = 3  
FROM [SHARPS].Turnos T
INNER JOIN Agendas A  ON A.Profesional = @MedicoID
WHERE T.Agenda = A.AgendaID AND CONVERT(CHAR(10), A.Horario ,112) = @Fecha

UPDATE Agendas SET Activo = 0
WHERE Profesional = @MedicoID AND CONVERT(CHAR(10), Horario ,112) = @Fecha 
END
GO


CREATE PROCEDURE [SHARPS].[GetBonos]

@userId int

AS
BEGIN
DECLARE @GRUPO INT
SELECT @GRUPO = GrupoFamiliar FROM Afiliados WHERE UsuarioID =@userId

SELECT BC.Fecha_Impresion AS Fecha , BC.Numero AS Numero , BC.Precio_Pagado AS Precio ,'Consulta' AS TipoBono
FROM [SHARPS].Bonos_Consulta BC
INNER JOIN Afiliados A ON A.GrupoFamiliar = @GRUPO 
INNER JOIN Consultas C ON C.Bono_Consulta <> BC.Numero
WHERE BC.Afiliado_Compro = @userId OR BC.Afiliado_Compro = A.UsuarioID
 

UNION

SELECT BF.Fecha_Impresion AS Fecha, BF.Numero AS Numero ,BF.Precio_Pagado AS Precio , 'Farmacia' AS TipoBono
FROM [SHARPS].Bonos_Farmacia BF
INNER JOIN Afiliados A ON A.GrupoFamiliar = @GRUPO 
INNER JOIN Recetas R ON R.Bono_Farmacia <> BF.Numero
WHERE BF.Afiliado_Compro = @userId OR BF.Afiliado_Compro = A.UsuarioID
AND DATEADD(day, 60, BF.Fecha_Impresion) >= GETDATE()
order by 4

END
GO



CREATE PROCEDURE [SHARPS].[ComprarBonoConsulta]
@Precio INT,
@AfiliadoCompro INT,
@Fecha DATE
AS 
BEGIN
DECLARE @NUMEROBONO INT
DECLARE @PLAN INT
SELECT @PLAN = A.Plan_Medico FROM Afiliados A WHERE A.UsuarioID = @AfiliadoCompro 
SELECT @NUMEROBONO = MAX(Numero) + 1  FROM [SHARPS].Bonos_Consulta 
INSERT INTO [SHARPS].Bonos_Consulta (Numero,Fecha_Impresion,Afiliado_Compro,Precio_Pagado)
VALUES (@NUMEROBONO  , @Fecha , @AfiliadoCompro,@Precio)
RETURN @NUMEROBONO 
END
GO



CREATE PROCEDURE [SHARPS].[ComprarBonoReceta] 
@Precio INT,
@AfiliadoCompro INT,
@Fecha DATE
AS 
BEGIN
DECLARE @NUMEROBONO INT
DECLARE @PLAN INT
SELECT @PLAN = A.Plan_Medico FROM Afiliados A WHERE A.UsuarioID = @AfiliadoCompro 
SELECT @NUMEROBONO = MAX(Numero) + 1 FROM [SHARPS].Bonos_Farmacia
INSERT INTO [SHARPS].Bonos_Farmacia(Numero,Fecha_Impresion,Afiliado_Compro,Precio_Pagado)
VALUES (@NUMEROBONO  , @Fecha , @AfiliadoCompro,@Precio)
RETURN @NUMEROBONO
END
GO



CREATE PROCEDURE [SHARPS].[GetAllAfiliadoTurnos]
@userId INT,
@fecha DATE


AS
BEGIN

SELECT T.FechaHoraLlegada as Fecha ,T.Numero as Numero ,A.Profesional AS UserProfesional ,P.Matricula AS Matricula
FROM Turnos T
INNER JOIN Agendas A ON A.AgendaID = T.Agenda
INNER JOIN Profesionales P ON P.UsuarioID = A.Profesional
WHERE T.Afiliado = @userId AND CONVERT(CHAR(10), A.Horario ,112) >= @fecha 

END
GO



CREATE PROCEDURE [SHARPS].[GetTurnosByProfesional]
@profesionalID INT,
@fecha DATE

AS
BEGIN

SELECT CONVERT(VARCHAR,A.Horario,108) Hora , CONVERT(CHAR(10), A.Horario ,112) AS Fecha 
FROM Agendas A
WHERE A.Profesional = @profesionalID
AND A.Horario = @fecha AND A.Activo = 0

END
GO 


CREATE PROCEDURE [SHARPS].[InsertTurno]
@Fecha DATE,
@Profesional_ID INT,
@Afiliado_ID INT

AS
BEGIN

DECLARE @IDAGENDA INT
DECLARE @NUMERO INT
SELECT @NUMERO = MAX(Numero) + 1 FROM [SHARPS].Turnos
SELECT @IDAGENDA = AgendaID FROM [SHARPS].Agendas A WHERE A.Profesional = @Profesional_ID
INSERT INTO [SHARPS].Turnos (Numero , Afiliado , Estado , FechaHoraLlegada , Agenda )
VALUES (@NUMERO , @Afiliado_ID, 3 , NULL,@IDAGENDA)
UPDATE Agendas SET Activo = 1 
WHERE Horario = @Fecha AND Profesional = @Profesional_ID

END
GO 


CREATE PROCEDURE [SHARPS].[RegistrarLlegada]
@Profesional_ID INT,
@HoraLlegada DATE, 
@Afiliado_ID INT,
@NCONSULTA INT
AS
BEGIN
DECLARE @TURNO INT 

UPDATE SHARPS.Turnos SET Estado = 1 , FechaHoraLlegada = @HoraLlegada
FROM SHARPS.Turnos T 
INNER JOIN Agendas A ON A.Profesional = @Profesional_ID AND A.Activo = 1
WHERE T.Afiliado = @Afiliado_ID AND T.Agenda = A.AgendaID 

SELECT @TURNO = T.Numero FROM SHARPS.Turnos T 
INNER JOIN Agendas A ON A.Profesional = @Profesional_ID AND A.Activo = 1
WHERE T.Afiliado = @Afiliado_ID AND T.Agenda = A.AgendaID 
SELECT @NCONSULTA = MAX(A.cantConsultas) + 1 FROM [SHARPS].Afiliados A WHERE A.UsuarioID = @Afiliado_ID
UPDATE Afiliados SET CantConsultas = @NCONSULTA  WHERE UsuarioID = @Afiliado_ID
INSERT INTO Consultas (Turno,Numero_Consulta) VALUES (@TURNO,@NCONSULTA)
END
GO

/*
CREATE PROCEDURE  [SHARPS].[InsertConsulta]
@Turno INT,
@Sintomas NVARCHAR(MAX),
@Enfermedad NVARCHAR(MAX)
AS
BEGIN

DECLARE @NCONSULTA INT
DECLARE @BONO INT
SELECT @NCONSULTA = MAX(A.cantConsultas) + 1 FROM [SHARPS].Afiliados A INNER JOIN SHARPS.Turnos T ON T.Numero = @Turno AND A.UsuarioID = T.Afiliado 
UPDATE Afiliados  SET cantConsultas = @NCONSULTA
FROM [SHARPS].Afiliados A INNER JOIN SHARPS.Turnos T ON T.Numero = @Turno AND A.UsuarioID = T.Afiliado


INSERT INTO Consultas (Turno, Sintomas , Numero_Consulta , Enfermedad , Bono)
VALUES (@Turno , @Sintomas ,@NCONSULTA ,@Enfermedad, ) ---<----- ACA NO CONVIENE PASARME EL NUMERO DE  BONO YA QUE UN AFILIADO PUEDE CONPRARLO PERO NO USARLO

END
GO
*/

CREATE PROCEDURE [SHARPS].[InsertConsulta]
@Turno INT,
@Sintomas NVARCHAR(MAX),
@Enfermedad NVARCHAR(MAX)
AS
BEGIN
UPDATE Consultas SET Sintomas = @Sintomas , Enfermedad = @Enfermedad WHERE Turno = @Turno

END
GO

CREATE PROCEDURE [SHARPS].[DeleteUser]
@User_ID INT
AS
BEGIN

UPDATE SHARPS.Usuarios SET
Activo = 0
WHERE UsuarioID = @User_ID

UPDATE SHARPS.Afiliados SET Activo = 0
WHERE UsuarioID = @User_ID

UPDATE SHARPS.Profesionales SET Activo = 0
WHERE UsuarioID = @User_ID
UPDATE SHARPS.Agendas SET Activo = 0
WHERE Profesional = @User_ID
UPDATE SHARPS.Turnos SET Estado = 5
FROM SHARPS.Turnos T
INNER JOIN SHARPS.Agendas A ON A.AgendaID = T.Agenda
WHERE A.Profesional = @User_ID OR T.Afiliado = @User_ID
END
GO


CREATE PROCEDURE [SHARPS].[InsertReceta]
@BonoFarmacia INT
AS
BEGIN

INSERT INTO Recetas (Bono_Farmacia) VALUES (@BonoFarmacia)

END
GO 

CREATE PROCEDURE [SHARPS].[AgregarMedicamentos]
@BonoFarmacia INT,
@Medicamento  INT  
AS
BEGIN
   
INSERT INTO SHARPS.Recetas_Medicamentos ( Receta, Medicamento)
VALUES (@BonoFarmacia , @Medicamento)

END
GO

CREATE PROCEDURE [SHARPS].[GetProfesionalInfo]
@userId INT
as 
BEGIN

select distinct u.username UserName , a.matricula matricula,  dp.apellido Apellido, dp.nombre Nombre, dp.sexo Sexo
,dp.mail Email,dp.fechaNac FechaNacimiento, dp.TipoDNI, dp.telefono Telefono, dp.direccion Direccion, dp.dni DNI , A.Faltan_Datos FaltanDatos
from SHARPS.Usuarios u
inner join SHARPS.Profesionales a on a.UsuarioID = @userId
inner join SHARPS.Detalles_Persona dp on dp.UsuarioID = @userId
where u.UsuarioID = @userId

END
GO  

CREATE PROCEDURE [SHARPS].[GetMedicamentos]

AS
BEGIN

SELECT Codigo AS Numero , Descripcion AS Nombre
FROM SHARPS.Medicamentos

END
GO


CREATE PROCEDURE [SHARPS].[UpdateUserPassword]
	@ID_Usuario int,
	@OldPassword nvarchar(255),
	@NewPassword nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT 1 FROM Usuarios
	WHERE UsuarioID = @ID_Usuario AND password = @OldPassword

	IF @@ROWCOUNT = 1
	BEGIN
		UPDATE Usuarios 
		SET password = @NewPassword
		WHERE UsuarioID = @ID_Usuario
	END

END
GO



CREATE PROCEDURE [SHARPS].GetTurnosAfiliadoDate
@profesionalID INT,
@fecha DATE
AS
BEGIN

SELECT T.Numero , T.Afiliado , A.Horario
FROM Agendas A
INNER JOIN Turnos T ON T.Agenda = A.AgendaID AND A.Activo = 1
WHERE CONVERT(CHAR(10), A.Horario ,112) = @fecha AND A.Profesional = @profesionalID
END
GO


CREATE PROCEDURE  [SHARPS].CancelarTurnoAfiliado
@turno INT
AS
BEGIN

UPDATE SHARPS.Turnos SET Estado = 2
FROM Turnos T
INNER JOIN Agendas A ON A.AgendaID = T.Agenda
WHERE T.Numero = @turno  AND A.Activo = 1

END
GO

CREATE PROCEDURE [SHARPS].DeleteAfiliado
@ID INT
AS
BEGIN

UPDATE SHARPS.AFILIADOS SET Activo = 0
WHERE UsuarioID = @ID

END
GO


CREATE PROCEDURE [SHARPS].DeleteProfesional
@ID INT
AS
BEGIN

UPDATE SHARPS.Profesionales SET Activo = 0
WHERE UsuarioID = @ID

END
GO
USE [GD2C2013]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[InsertDiaProfesional]
	@Fecha datetime,
	@Profesional int
AS
BEGIN
	SET NOCOUNT ON;
	DELETE FROM SHARPS.Agendas WHERE Profesional = @Profesional AND Horario > @Fecha 
    --Si tiene un turno asignado en la fecha, deberiamos cancelarlo, de alguna manera
	INSERT INTO SHARPS.Agendas(Horario,Profesional, Activo) VALUES (@Fecha,@Profesional,1)
	--SELECT @@Identity AS ID
END

CREATE PROCEDURE [SHARPS].GetAfiliadosFromGrupoFamiliar
@GrupoFamiliar INT
AS
BEGIN

SELECT UsuarioID FROM Afiliados WHERE GrupoFamiliar = @GrupoFamiliar

END
GO