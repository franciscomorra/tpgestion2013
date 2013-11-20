USE [GD2C2013]
GO
/****** Object:  StoredProcedure [SHARPS].[InsertEspecialidad]    Script Date: 11/20/2013 16:21:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [SHARPS].Get_TOPCancelaciones
--Top 5 de las especialidades que más se registraron cancelaciones, 
--tanto de afiliados como de profesionales
	@fecha_inicio AS NVARCHAR(50),
	@fecha_fin AS NVARCHAR(50)
AS
BEGIN
	SELECT 
	TOP 5
	esp.nombreEspecialidad as Especialidad
	,COUNT (esp.nombreEspecialidad) AS Cantidad
	FROM (
		SELECT E.Descripcion as nombreEspecialidad, p.UsuarioID, ET.Descripcion AS DescripcionEstado
		FROM SHARPS.Especialidades e
		INNER JOIN SHARPS.Profesionales_Especialidades ep ON ep.Especialidad = e.Codigo
		INNER JOIN SHARPS.Profesionales p ON ep.Profesional = p.UsuarioID
		INNER JOIN SHARPS.Agendas a ON a.Profesional = p.UsuarioID
		INNER JOIN SHARPS.Turnos t ON t.Agenda = a.AgendaID
		INNER JOIN SHARPS.Estados_Turno et ON et.EstadoID = t.Estado
		WHERE (et.Descripcion = 'CanceladoAfiliado' OR et.Descripcion = 'CanceladoProfesional')
		AND a.Horario BETWEEN @fecha_inicio AND @fecha_fin
		GROUP BY   E.Descripcion , p.UsuarioID, ET.Descripcion
	)  esp
	GROUP BY esp.nombreEspecialidad
	ORDER BY Cantidad desc
END




 /*
[SHARPS].Get_TOPVencidos 
--Top 5 de la cantidad total de bonos farmacia vencidos por afiliado

[SHARPS].Get_TOPRecetados 
--Top 5 de las especialidades de médicos con más bonos de farmacia recetados
[SHARPS].Get_TOPVividores 
--Top 10 de los afiliados que utilizaron bonos que ellos mismo no compraron
*/