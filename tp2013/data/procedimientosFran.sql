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
/****** Object:  StoredProcedure [SHARPS].[GetTurnos]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetTurnos]
@userId INT


AS
BEGIN

SELECT a.Horario as Fecha ,T.Numero as Numero ,A.Profesional AS UserProfesional ,P.Matricula AS Matricula
FROM Turnos T
INNER JOIN Agendas A ON A.AgendaID = T.Agenda
INNER JOIN Profesionales P ON P.UsuarioID = A.Profesional
WHERE T.Afiliado = @userId

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
/****** Object:  StoredProcedure [SHARPS].[GetProfileInfo]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetProfileInfo]
@NombrePerfil varchar(MAX)
AS
BEGIN
	SELECT
		p.PerfilID
	FROM  [SHARPS].Perfiles p
	WHERE p.Descripcion = @NombrePerfil
END
GO
/****** Object:  StoredProcedure [SHARPS].[GetProfileFunctionalities]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetProfileFunctionalities]
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
		dp.dni DNI
	FROM  [SHARPS].USUARIOS u
	INNER JOIN [SHARPS].PROFESIONALES P on p.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
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
	WHERE pe.Profesional= @userId
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
CREATE PROCEDURE [SHARPS].[GetBonos]

@userId int

AS
BEGIN

SELECT BC.Fecha_Impresion AS Fecha , BC.NumeroDeBono AS Numero , P.Precio_Bono_Consulta AS Precio, 'Consulta' as TipoBono
FROM [SHARPS].BonosConsulta BC
INNER JOIN Planes_Medicos P ON P.Codigo = BC.PlanMedico
WHERE BC.Afiliado_Compro = @userId
UNION
SELECT BF.Fecha_Impresion AS Fecha, BF.NumeroDeBono AS Numero ,P.Precio_Bono_Farmacia AS Precio, 'Farmacia' as TipoBono
FROM [SHARPS].BonosFarmacia BF
INNER JOIN Planes_Medicos P ON P.Codigo = BF.PlanMedico
WHERE BF.Afiliado_Compro = @userId



END
GO
/****** Object:  StoredProcedure [SHARPS].[GetAllTurnos]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[GetAllTurnos]
@userId INT


AS
BEGIN

SELECT a.Horario as Fecha ,T.Numero as Numero ,A.Profesional AS UserProfesional ,P.Matricula AS Matricula
FROM Turnos T
INNER JOIN Agendas A ON A.AgendaID = T.Agenda
INNER JOIN Profesionales P ON P.UsuarioID = A.Profesional
WHERE T.Afiliado = @userId

END
GO
/****** Object:  StoredProcedure [SHARPS].[GetAllEspecialidades]    Script Date: 11/10/2013 02:23:30 ******/
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
		dp.dni DNI
	FROM  [SHARPS].USUARIOS u
	INNER JOIN [SHARPS].AFILIADOS a on a.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].PLANES_MEDICOS pm on pm.codigo = a.planMedico
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].Estados_Civiles ec on ec.Codigo = a.EstadoCivil

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
	INNER JOIN [SHARPS].PLANES_MEDICOS pm on pm.codigo = a.planMedico
	INNER JOIN [SHARPS].DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	INNER JOIN [SHARPS].Estados_Civiles ec on ec.Codigo = a.EstadoCivil
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
CREATE PROCEDURE [SHARPS].[ComprarBonoReceta] --<-- TERMINAR DE REVISAR
@Precio INT,
@AfiliadoCompro INT,
@Fecha DATE
AS 
BEGIN
DECLARE @NUMEROBONO INT
DECLARE @PLAN INT
SELECT @PLAN = A.PlanMedico FROM Afiliados A WHERE A.UsuarioID = @AfiliadoCompro
SELECT @NUMEROBONO = MAX(NumeroDeBono) + 1 FROM [SHARPS].BonosConsulta -----REVISAR PARA EL NUMERO DE FARMACIA TAMBIEN
INSERT INTO [SHARPS].BonosFarmacia(NumeroDeBono,PlanMedico,Fecha_Impresion,Afiliado_Compro)
VALUES (@NUMEROBONO , @PLAN , @Fecha , @AfiliadoCompro)
END
GO
/****** Object:  StoredProcedure [SHARPS].[ComprarBonoConsulta]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[ComprarBonoConsulta]
@Precio INT,
@AfiliadoCompro INT,
@Fecha DATE
AS 
BEGIN
DECLARE @NUMEROBONO INT
DECLARE @PLAN INT
SELECT @PLAN = A.PlanMedico FROM Afiliados A WHERE A.UsuarioID = @AfiliadoCompro
SELECT @NUMEROBONO = MAX(NumeroDeBono) + 1 FROM [SHARPS].BonosConsulta -----REVISAR PARA EL NUMERO DE FARMACIA TAMBIEN
INSERT INTO [SHARPS].BonosConsulta (NumeroDeBono,PlanMedico,Fecha_Impresion,Afiliado_Compro)
VALUES (@NUMEROBONO , @PLAN , @Fecha , @AfiliadoCompro)
END
GO
/****** Object:  StoredProcedure [SHARPS].[CancelarDiaProfesional]    Script Date: 11/10/2013 02:23:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SHARPS].[CancelarDiaProfesional]
@MedicoID int,
@Fecha date

AS
BEGIN



UPDATE [SHARPS].Estados_Turno
SET MotivoCancelacion = 'cancelacion medico'  ---<---  REVISAR
,Descripcion ='cancelado'
FROM [SHARPS].Estados_Turno ET
INNER JOIN Agendas A  ON A.AgendaID = @MedicoID
INNER JOIN  [SHARPS].Turnos T ON T.Estado = ET.Estado
WHERE T.Agenda = A.AgendaID AND CONVERT(CHAR(10), T.FechaHoraLlegada ,112) = @Fecha

END
GO
/****** Object:  StoredProcedure [SHARPS].[Login]    Script Date: 11/10/2013 02:23:31 ******/
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
CREATE PROCEDURE [SHARPS].[InsertSpeciality]
@MedicoID int,
@Especialidad int

AS
BEGIN
INSERT INTO [SHARPS].Profesionales_Especialidades (Profesional , Especialidad) VALUES (@MedicoID , @Especialidad)
/*SELECT TOP 1  @MedicoID , E.Codigo
FROM Especialidades E
WHERE E.Descripcion = @Especialidad*/

END
GO
/****** Object:  StoredProcedure [SHARPS].[InsertRoleFunctionality]    Script Date: 11/10/2013 02:23:31 ******/
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
