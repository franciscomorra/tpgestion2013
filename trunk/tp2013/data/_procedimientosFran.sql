USE [GD2C2013]
GO
/****** Object:  StoredProcedure [dbo].[NuevoGrupoFamiliar]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[NuevoGrupoFamiliar] 
	@max int
AS
begin
	select @max  = @max + 1
end
GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Login]
	@Nombre nvarchar(255),
	@Password nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT UsuarioID as ID, username as Nombre, activo as estado FROM Usuarios WHERE
	username = @Nombre AND Password = @Password AND Activo = 1
	
	IF @@ROWCOUNT = 0
		BEGIN
			UPDATE Usuarios SET Intentos = Intentos + 1
			WHERE username = @Nombre
		END
	ELSE
		BEGIN
			UPDATE Usuarios SET Intentos = 0
			WHERE username = @Nombre
		END
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserRoles]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserRoles] 
@userID int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT r.RolID as ID, r.Descripcion as Descripcion, r.Perfil as PerfilId, p.Descripcion as PerfilNombre
	FROM Roles r
	INNER JOIN Usuarios_Roles ur ON ur.Rol = r.RolID
	INNER JOIN Perfiles p on p.PerfilID = r.Perfil
	WHERE ur.usuario = @userID
	ORDER BY r.Descripcion

END
GO
/****** Object:  StoredProcedure [dbo].[GetUserLoginAttempts]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserLoginAttempts]
	@Nombre nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT Intentos FROM Usuarios WHERE username = @Nombre
	IF(@@ROWCOUNT = 0)
		SELECT 0 AS Intentos
END
GO
/****** Object:  StoredProcedure [dbo].[GetRolesByPerfil]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRolesByPerfil]
@Perfil nvarchar(max)
AS
BEGIN
	SELECT
		r.RolID,
		r.Descripcion
	FROM Roles r
	INNER JOIN Perfiles p ON r.Perfil = p.PerfilID 
	--WHERE r.Activo = 1
	WHERE p.Descripcion = @Perfil 
END
GO
/****** Object:  StoredProcedure [dbo].[GetRoles]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRoles]

AS
BEGIN
	SELECT
		r.RolID ID,
		r.Descripcion,
		r.Perfil as PerfilID,
		p.Descripcion as PerfilNombre
	FROM Roles r
	INNER JOIN Perfiles p ON p.PerfilID = r.Perfil
END
GO
/****** Object:  StoredProcedure [dbo].[GetRoleFunctionalities]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetRoleFunctionalities]
	@Rol_ID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT F.Descripcion FROM Funcionalidades F
	INNER JOIN Roles_Funcionalidades RF ON F.Codigo = RF.Funcionalidad
	WHERE RF.Rol = @Rol_ID
END
GO
/****** Object:  StoredProcedure [dbo].[GetProfileInfo]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProfileInfo]
@NombrePerfil varchar(MAX)
AS
BEGIN
	SELECT
		p.PerfilID
	FROM Perfiles p
	WHERE p.Descripcion = @NombrePerfil
END
GO
/****** Object:  StoredProcedure [dbo].[GetPlanesMedicos]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPlanesMedicos]

AS
BEGIN
	SELECT
		pm.Codigo,
		pm.Descripcion,
		pm.Precio_Bono_Consulta,
		pm.Precio_Bono_Farmacia
	FROM Planes_Medicos pm
END
GO
/****** Object:  StoredProcedure [dbo].[GetPerfiles]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPerfiles]

AS
BEGIN
	SELECT
		p.PerfilID ID,
		p.Descripcion
	FROM Perfiles p
END
GO
/****** Object:  StoredProcedure [dbo].[GetEspecialidades]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetEspecialidades]
@userId INT
AS
BEGIN
	SELECT
		e.Codigo ID,
		e.Descripcion
	FROM Especialidades e
	INNER JOIN Profesionales_Especialidades pe ON pe.Especialidad = e.Codigo
	INNER JOIN Profesionales p ON p.UsuarioID = @userId
END
GO
/****** Object:  StoredProcedure [dbo].[GetAfiliados]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAfiliados]

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
	FROM USUARIOS u
	inner join AFILIADOS a on a.usuarioID = u.usuarioID
	inner join PLANES_MEDICOS pm on pm.codigo = a.planMedico
	inner join DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	inner join Estados_Civiles ec on ec.Codigo = a.EstadoCivil

	ORDER BY U.UsuarioID

END
GO
/****** Object:  StoredProcedure [dbo].[GetProfesionales]    Script Date: 11/04/2013 01:50:07 ******/
use GD2C2013
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProfesionales]

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
	FROM USUARIOS u
	inner join PROFESIONALES P on p.usuarioID = u.usuarioID
	inner join DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	ORDER BY U.UsuarioID

END
GO
/****** Object:  StoredProcedure [dbo].[GetAfiliadoInfo]    Script Date: 11/04/2013 01:50:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAfiliadoInfo]
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
	FROM USUARIOS u
	inner join AFILIADOS a on a.usuarioID = u.usuarioID
	inner join PLANES_MEDICOS pm on pm.codigo = a.planMedico
	inner join DETALLES_PERSONA dp on dp.usuarioID = u.usuarioID
	inner join Estados_Civiles ec on ec.Codigo = a.EstadoCivil
	WHERE A.UsuarioID = @userId
	ORDER BY U.UsuarioID

END
GO
