USE [GD2C2013]
GO
/****** Object:  StoredProcedure [SHARPS].[InsertEspecialidad]    Script Date: 11/20/2013 16:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Top 5 de las especialidades que más se registraron cancelaciones, 
tanto de afiliados como de profesionales*/

CREATE PROCEDURE [SHARPS].Get_TOPCancelaciones

	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT TOP 5 e.Descripcion 	,COUNT (e.Descripcion) AS Cantidad
		FROM [SHARPS].Especialidades e
		INNER JOIN [SHARPS].Profesionales_Especialidades ep ON ep.Especialidad = e.Codigo
		INNER JOIN [SHARPS].Profesionales p ON ep.Profesional = p.UsuarioID
		INNER JOIN [SHARPS].Agendas a ON a.Profesional = p.UsuarioID
		INNER JOIN [SHARPS].Turnos t ON t.Agenda = a.AgendaID
		INNER JOIN [SHARPS].Estados_Turno et ON et.EstadoID = t.Estado
		WHERE (et.Descripcion = 'CanceladoAfiliado' OR et.Descripcion = 'CanceladoProfesional')
		AND a.Horario BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY   e.Descripcion
		ORDER BY Cantidad desc
END


 /*Top 5 de la cantidad total de bonos farmacia vencidos por afiliado*/
 
CREATE PROCEDURE [SHARPS].Get_TOPVencidos

	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT TOP 5 a.UsuarioID,	COUNT (bf.Numero) AS Cantidad
		FROM [SHARPS].Bonos_Farmacia bf
		INNER JOIN [SHARPS].Compras c ON c.CompraID = bf.Compra
		INNER JOIN [SHARPS].Afiliados a ON a.UsuarioID = c.Afiliado
		--OUTER JOIN SHARPS.Recetas r ON r.Bono_Farmacia = bf.Numero -- registros de una tabla que no tengan correspondencia en la otra.
		WHERE (c.fechaCompra <= bf.Fecha_Impresion + 60) --como poner que este entre fecha de impresion y 60 dias...
		AND a.Horario BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY   a.UsuarioID
		ORDER BY Cantidad Desc
END


/*Top 5 de las especialidades de médicos con más bonos de farmacia recetados*/

--Como encuentro los bonos de farmacia recetados por una especialidad?

CREATE PROCEDURE [SHARPS].Get_TOPRecetados 

	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT TOP 5 e.Descripcion, COUNT(r.Bono_Farmacia) As Cantidad
		FROM [SHARPS].Especialidades e
		INNER JOIN [SHARPS].Profesionales_Especialidades ep ON ep.Especialidad = e.Codigo
		INNER JOIN [SHARPS].Profesionales p ON ep.Profesional = p.UsuarioID
		INNER JOIN [SHARPS].Agendas a ON a.Profesional = p.UsuarioID
		INNER JOIN [SHARPS].Turnos t ON t.Agenda = a.AgendaID
		INNER JOIN [SHARPS].Consultas c ON c.Turno = t.Numero
		INNER JOIN [SHARPS].Recetas r ON r.Consulta = c.Bono_Consulta
		WHERE a.Horario BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY   e.Descripcion 
		ORDER BY Cantidad Desc
END


/*Top 10 de los afiliados que utilizaron bonos que ellos mismo no compraron*/ --NO TERMINADO

CREATE PROCEDURE [SHARPS].Get_TOPVividores --OUTER JOIN, mismo caso que el 2...COMPRAID NO COINCIDA CON COMPRA

	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT TOP 10 D.Nombre,D.Apellido,A2.GrupoFamiliar,A2.TipoAfiliado
	FROM SHARPS.Afiliados A
	JOIN SHARPS.Compras COM ON COM.Afiliado = A.UsuarioID
	JOIN SHARPS.Bonos_Consulta BC ON BC.Compra = COM.CompraID
	JOIN SHARPS.Consultas CON ON CON.Bono_Consulta = BC.Numero
	JOIN SHARPS.Turnos T ON CON.Turno = T.Numero
	JOIN SHARPS.Agendas AG ON AG.AgendaID = T.Agenda
	JOIN SHARPS.Afiliados A2 ON A2.UsuarioID = T.Afiliado
	JOIN SHARPS.Detalles_Persona D ON D.UsuarioID = A2.UsuarioID
	WHERE A2.UsuarioID <> A.UsuarioID
	AND AG.Horario BETWEEN @fecha_inicio AND @fecha_fin
END
