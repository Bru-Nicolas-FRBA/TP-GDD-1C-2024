--cosas para corregir
/*
	Que pingoe es venta y de donde lo sacamos
	solo se pueden mostrar cosas de la tablas de entrega y 2 hechos
	
	no hacer procedure solo insert into
	hacer pruebas al final if exists
*/
USE [GD1C2024]
GO

CREATE SCHEMA [BI_REYES_DE_DATOS]
GO
----- ----- ----- ----- ----- ----- ----- ----- 
----- CREACIÓN DE TABLAS-DIMENSIONES ----- 
----- ----- ----- ----- ----- ----- ----- ----- 
CREATE TABLE BI_REYES_DE_DATOS.BI_Tiempo(
	id_tiempo INT PRIMARY KEY IDENTITY(1,1),
	anio INT NOT NULL, 
	cuatrimestre INT NOT NULL,
	mes INT NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Ubicacion(
	id_ubicacion INT PRIMARY KEY IDENTITY(1,1),
	id_provincia INT NOT NULL,
	id_localidad INT NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Sucursal(
	id_sucursal INT PRIMARY KEY IDENTITY(1,1)
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Rango_Etario(
	id_rango_etario INT PRIMARY KEY,
	rango_etario NVARCHAR(255) NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_turno(
    id_turno INT PRIMARY KEY IDENTITY(1,1),
    turno NVARCHAR(255) NOT NULL
);
-----
--mmmmmMMMMMMM en nuestra tabla de medio de pago tenemos medio_de_pago_clasificacion y medio_de_pago_detalle.... ver de cambiar
CREATE TABLE BI_REYES_DE_DATOS.BI_medio_de_pago(
    id_medio_de_pago INT PRIMARY KEY IDENTITY(1,1),
    costo DECIMAL(18,2) NOT NULL,
    medio_de_pago NVARCHAR(255) NOT NULL
);
----- ----- ----- ----- ----- ----- 
----- TABLAS ADICIONALES -----
----- ----- ----- ----- ----- -----
CREATE TABLE BI_REYES_DE_DATOS.BI_categoria_producto(
    id_categoria_producto INT PRIMARY KEY IDENTITY(1,1),
    categoria_producto NVARCHAR(255) NOT NULL,
    subcategoria_producto NVARCHAR(255) NULL -- NULL es para categorías que no tienen subcategoría
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Cliente (
    id_cliente INT PRIMARY KEY,
    cliente_nombre VARCHAR(100),
    cliente_apellido VARCHAR(100),
    cliente_fecha_nacimiento DATE,
    cliente_mail VARCHAR(255),
    
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Producto (
    id_producto INT PRIMARY KEY,
    producto_nombre VARCHAR(100),
    producto_descripcion VARCHAR(100),
    producto_precio DECIMAL(10,2),
    id_producto_categoria INT,
    id_producto_subcategoria INT,
    id_marca INT,
    
);
-----
/*
	--kk ke es esto
	CREATE VIEW BI_Venta AS
	SELECT
		t.id_ticket,
		t.ticket_fecha_hora,
		c.id_cliente,
		c.cliente_nombre,
		c.cliente_apellido,
		p.id_producto,
		p.producto_nombre,
		p.producto_precio
    
	FROM
		dbo.Ticket t
		JOIN dbo.Cliente c ON t.id_cliente = c.id_cliente
		JOIN dbo.Item_Ticket it ON t.id_ticket = it.id_ticket
		JOIN dbo.Producto p ON it.id_producto = p.id_producto;
*/
GO
----- ----- ----- ----- ----- ----- -----
-----  CREACIÓN DE TABLAS-HECHOS ----- 
----- ----- ----- ----- ----- ----- -----
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_ventas(
	id_venta INT PRIMARY KEY IDENTITY(1,1),
	id_tiempo INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_Tiempo(id_tiempo) NOT NULL,
);

GO
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_ventas ADD CONSTRAINT PK_BI_Venta_id_venta PRIMARY KEY (id_venta)
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_ventas ADD CONSTRAINT FK_BI_Venta_id_cliente FOREIGN KEY (id_cliente) REFERENCES BI_Cliente(id_cliente)
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_ventas ADD CONSTRAINT FK_BI_Venta_id_producto FOREIGN KEY (id_producto) REFERENCES BI_Producto(id_producto)
GO
----- ----- ----- ----- ----- ----
-----  CREACIÓN DE FUNCIONES -----
----- ----- ----- ----- ----- ----- 

CREATE FUNCTION BI_REYES_DE_DATOS.rangoEtario(@fechaNacimiento AS DATE)
RETURNS INT
AS
BEGIN
	DECLARE @edad INT
	SET @edad = YEAR(GETDATE()) - YEAR(@fechaNacimiento) 
	DECLARE @rangoEtario INT
	
	IF(@edad < 25)
		SET @rangoEtario = 1
	IF(@edad BETWEEN 25 AND 34)
		SET @rangoEtario = 2
	IF(@edad BETWEEN 35 AND 50)
		SET @rangoEtario = 3
	IF(@edad > 50)
		SET @rangoEtario = 4

RETURN @rangoEtario
END
GO
----- 
CREATE FUNCTION BI_REYES_DE_DATOS.cuatrimestre(@mes INT)
RETURNS INT
AS
BEGIN
	DECLARE @cuatrimestre INT

	IF(@mes BETWEEN 1 AND 4)
	SET @cuatrimestre = 1
	IF (@mes BETWEEN 5 AND 8)
	SET @cuatrimestre = 2
	IF (@mes BETWEEN 9 AND 12)
	SET @cuatrimestre = 3

 RETURN @cuatrimestre
	
END
GO
----- ----- ----- ----- ----- ----- 
-----  CREACIÓN DE MIGRACIONES -----
----- ----- ----- ----- ----- ----- 
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_Cliente(
	id_cliente,
	--cliente_dni,
	cliente_nombre,
	cliente_apellido,
	--cliente_fecha_registro,
	cliente_mail,
	cliente_fecha_nacimiento)
SELECT
	id_cliente,
	cliente_dni,
	cliente_nombre,
	cliente_apellido,
	cliente_fecha_registro,
	cliente_mail,
	cliente_fecha_nacimiento
FROM REYES_DE_DATOS.Cliente;
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_Producto(
	id_producto,
	producto_nombre,
	producto_descripcion,
	producto_precio
)
SELECT 
	id_producto,
	producto_descripcion,
	producto_precio
FROM REYES_DE_DATOS.Producto;
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_Venta(
	id_venta,
	id_cliente,
	id_producto,
	fecha_venta,
	cantidad_vendida,
	monto_total
)
SELECT 
	id_venta, 
	id_cliente,
	id_producto,
	fecha_venta,
	cantidad_vendida,
	monto_total
FROM BI_REYES_DE_DATOS.Venta;
-----
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (1, '<25')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (2, '25-34')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (3, '35-50')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (4, '<50')
PRINT 'Migración de BI_rango_etario terminada';
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_tiempo(
	anio,
	cuatrimestre,
	mes
)	
SELECT DISTINCT 
	YEAR(fecha),
	BI_REYES_DE_DATOS.cuatrimestre(MONTH(fecha)),
	MONTH(fecha)
	--ver si agregar tiempo de envio y ticket
FROM REYES_DE_DATOS.Pago
PRINT 'Migración de BI_tiempo terminada';
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_ubicacion(
	id_provincia,
	id_localidad
)
SELECT 
	p.id_provincia, 
	l.id_localidad
FROM REYES_DE_DATOS.Provincia p
	CROSS JOIN REYES_DE_DATOS.Localidad l
PRINT 'Migración de BI_ubicación terminada'
----- 
--no sé que tanto sentido tiene migrar la sucursal que solo tiene un campo (id_sucursal) el cual es una PK que se va a ir incrementando sola
--INSERT INTO BI_REYES_DE_DATOS.BI_sucursal
PRINT 'Migración de BI_sucursal terminada'
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('08:00 - 12:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('12:00 - 16:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('16:00 - 20:00')
PRINT 'Migración de BI_turno terminada'
----- 
-- Primero hacer bien la tabla medio de pago, creo que está mal o habría que revisar
PRINT 'Migración de BI_medio_de_pago terminada'
----- 
INSERT INTO BI_REYES_DE_DATOS.BI_categoria_producto(
	categoria_producto,
	subcategoria_producto
	-- ver si precisamos los números/id o detalles
) 
SELECT
	c.producto_categoria_detalle,
	s.producto_subategoria_detalle
FROM REYES_DE_DATOS.Producto_categoria c
	CROSS JOIN REYES_DE_DATOS.Producto_subcategoria s
PRINT 'Migración de BI_categoria_producto terminada'
GO

----- ----- ----- ----- ----- 
----- CREACION DE VIEWS ----- 
----- ----- ----- ----- ----- 

----- 
-- 1) Vista para calcular el ticket promedio mensual por localidad, año y mes
----- 
CREATE VIEW Vista_Ticket_Promedio_Mensual AS
SELECT
    YEAR(t.ticket_fecha_hora) AS anio,
    MONTH(t.ticket_fecha_hora) AS mes,
    l.localidad_nombre,
    AVG(it.item_precio_total) AS ticket_promedio
FROM
    --kk de aca solo se usa hechos
	Ticket t
    JOIN Cliente c ON t.id_cliente = c.id_cliente
    JOIN Localidad l ON c.id_localidad = l.id_localidad
    JOIN Item_Ticket it ON t.id_ticket = it.id_ticket
GROUP BY
    YEAR(t.ticket_fecha_hora),
    MONTH(t.ticket_fecha_hora),
    l.localidad_nombre;
GO
----- 
-- 2) Vista para calcular la cantidad de unidades promedio por turno para cada cuatrimestre de cada año
----- 
CREATE VIEW Vista_Cantidad_Unidades_Promedio AS
SELECT
    YEAR(t.ticket_fecha_hora) AS anio,
    (MONTH(t.ticket_fecha_hora) - 1) / 4 + 1 AS cuatrimestre,
    DATEPART(HOUR, t.ticket_fecha_hora) AS hora,
    AVG(it.item_cantidad) AS cantidad_unidades_promedio
FROM
    Ticket t
    JOIN Item_Ticket it ON t.id_ticket = it.id_ticket
GROUP BY
    YEAR(t.ticket_fecha_hora),
    (MONTH(t.ticket_fecha_hora) - 1) / 4 + 1,
    DATEPART(HOUR, t.ticket_fecha_hora);
GO
----- 
-- 3) Vista para calcular porcentaje anual de ventas registradas por rango etario del empleado según el tipo de caja para cada cuatrimestre.
----- 
CREATE VIEW BI_Porcentaje_Ventas_Rango_Etario AS
SELECT
    YEAR(Venta.fecha_venta) AS anio,
    CASE
        WHEN MONTH(Venta.fecha_venta) BETWEEN 1 AND 3 THEN '1er Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 4 AND 6 THEN '2do Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 7 AND 9 THEN '3er Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 10 AND 12 THEN '4to Cuatrimestre'
    END AS cuatrimestre,
    Empleado.rango_etario AS rango_etario_empleado,
    Venta.tipo_caja,
    COUNT(*) AS cantidad_ventas,
    SUM(Venta.monto_total) AS monto_total_ventas
FROM
    BI_Venta AS Venta
    JOIN Empleado ON Venta.id_empleado = Empleado.id_empleado
GROUP BY
    YEAR(Venta.fecha_venta),
    CASE
        WHEN MONTH(Venta.fecha_venta) BETWEEN 1 AND 3 THEN '1er Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 4 AND 6 THEN '2do Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 7 AND 9 THEN '3er Cuatrimestre'
        WHEN MONTH(Venta.fecha_venta) BETWEEN 10 AND 12 THEN '4to Cuatrimestre'
    END,
    Empleado.rango_etario,
    Venta.tipo_caja;
GO
----- 
-- 4) Vista para calcular cantidad de ventas registradas por turno para cada localidad según el mes de cada año
----- .
CREATE VIEW Vista_Cantidad_Ventas_Por_Turno_Y_Localidad AS
SELECT
    YEAR(v.fecha_venta) AS anio,
    MONTH(v.fecha_venta) AS mes,
    v.localidad,
    v.turno,
    COUNT(*) AS cantidad_ventas
FROM
    Venta v
GROUP BY
    YEAR(v.fecha_venta),
    MONTH(v.fecha_venta),
    v.localidad,
    v.turno;
GO
----- 
-- 5) Vista para calcular el porcentaje de descuento aplicados en función del total de los tickets según el mes de cada año
----- 
CREATE VIEW BI_Porcentaje_Descuento_Por_Mes AS
SELECT
    YEAR(v.fecha_venta) AS anio,
    MONTH(v.fecha_venta) AS mes,
    SUM(v.descuento) AS total_descuento,
    SUM(v.monto_total) AS total_importe,
    (SUM(v.descuento) / SUM(v.monto_total)) * 100 AS porcentaje_descuento
FROM
    BI_Venta v
GROUP BY
    YEAR(v.fecha_venta),
    MONTH(v.fecha_venta)
ORDER BY
    YEAR(v.fecha_venta),
    MONTH(v.fecha_venta);
GO
----- 
-- 6) Vista para calcular las tres categorías de productos con mayor descuento aplicado a partir de promociones para cada cuatrimestre de cada año.
----- 
CREATE VIEW Vista_Categorias_Productos_Con_Mayor_Descuento AS
SELECT
    YEAR(p.fecha_inicio) AS anio,
    CASE
        WHEN MONTH(p.fecha_inicio) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(p.fecha_inicio) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(p.fecha_inicio) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END AS cuatrimestre,
    pr.categoria,
    AVG(p.descuento) AS descuento_promedio
FROM
    Promocion p
    JOIN Producto pr ON p.id_producto = pr.id_producto
GROUP BY
    YEAR(p.fecha_inicio),
    CASE
        WHEN MONTH(p.fecha_inicio) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(p.fecha_inicio) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(p.fecha_inicio) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END,
    pr.categoria
ORDER BY
    YEAR(p.fecha_inicio),
    CASE
        WHEN MONTH(p.fecha_inicio) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN MONTH(p.fecha_inicio) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN MONTH(p.fecha_inicio) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
    END,
    AVG(p.descuento) DESC;
GO
----- 
-- 7) Vista para calcular porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
----- 
CREATE VIEW BI_Porcentaje_Cumplimiento_Envios AS
SELECT
    YEAR(Envio.fecha_entrega_programada) AS anio,
    MONTH(Envio.fecha_entrega_programada) AS mes,
    Sucursal.nombre AS nombre_sucursal,
    COUNT(*) AS total_envios,
    SUM(CASE WHEN Envio.fecha_entrega_real IS NOT NULL THEN 1 ELSE 0 END) AS envios_cumplidos,
    (SUM(CASE WHEN Envio.fecha_entrega_real IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS porcentaje_cumplimiento
FROM
    BI_Envio AS Envio
    JOIN BI_Sucursal AS Sucursal ON Envio.id_sucursal = Sucursal.id_sucursal
GROUP BY
    YEAR(Envio.fecha_entrega_programada),
    MONTH(Envio.fecha_entrega_programada),
    Sucursal.nombre;
GO
----- 
-- 8) Vista para calcular la cantidad de envíos por rango etario de clientes para cada cuatrimestre de cada año.
----- 
CREATE VIEW BI_Cantidad_Envios_Rango_Etario AS
SELECT
    YEAR(Envio.fecha_envio) AS anio,
    CASE
        WHEN MONTH(Envio.fecha_envio) BETWEEN 1 AND 3 THEN '1er Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 4 AND 6 THEN '2do Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 7 AND 9 THEN '3er Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 10 AND 12 THEN '4to Cuatrimestre'
    END AS cuatrimestre,
    Cliente.rango_etario,
    COUNT(*) AS cantidad_envios
FROM
    BI_Envio AS Envio
    JOIN BI_Cliente AS Cliente ON Envio.id_cliente = Cliente.id_cliente
GROUP BY
    YEAR(Envio.fecha_envio),
    CASE
        WHEN MONTH(Envio.fecha_envio) BETWEEN 1 AND 3 THEN '1er Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 4 AND 6 THEN '2do Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 7 AND 9 THEN '3er Cuatrimestre'
        WHEN MONTH(Envio.fecha_envio) BETWEEN 10 AND 12 THEN '4to Cuatrimestre'
    END,
    Cliente.rango_etario;
GO
----- 
-- 9) Vista para calcular las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.
----- 
CREATE VIEW BI_Top5_Localidades_Costo_Envio AS
SELECT TOP 5
    Cliente.localidad AS nombre_localidad,
    SUM(Envio.costo_envio) AS total_costo_envio
FROM
    BI_Envio AS Envio
    JOIN BI_Cliente AS Cliente ON Envio.id_cliente = Cliente.id_cliente
GROUP BY
    Cliente.localidad
ORDER BY
    SUM(Envio.costo_envio) DESC;
GO
----- 
-- 10) Vista para calcular las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de pago, mes y año.
----- 
CREATE VIEW BI_Top3_Sucursales_Pagos_Cuotas AS
SELECT TOP 3
    Sucursal.nombre AS nombre_sucursal,
    Medio_Pago.nombre AS nombre_medio_pago,
    YEAR(Venta.fecha_venta) AS año,
    MONTH(Venta.fecha_venta) AS mes,
    SUM(Venta.monto_total) AS total_pagos_cuotas
FROM
    BI_Venta AS Venta
    JOIN BI_Medio_Pago AS Medio_Pago ON Venta.id_medio_pago = Medio_Pago.id_medio_pago
    JOIN BI_Sucursal AS Sucursal ON Venta.id_sucursal = Sucursal.id_sucursal
WHERE
    Medio_Pago.tipo_pago = 'Cuotas'
GROUP BY
    Sucursal.nombre,
    Medio_Pago.nombre,
    YEAR(Venta.fecha_venta),
    MONTH(Venta.fecha_venta)
ORDER BY
    SUM(Venta.monto_total) DESC;
GO
----- 
-- 11) Vista para calcular el promedio de importe de la cuota en función del rango etareo del cliente.
----- 
CREATE VIEW BI_Promedio_Cuota_Rango_Etario AS
SELECT
    CASE
        WHEN Cliente.edad < 25 THEN '< 25'
        WHEN Cliente.edad >= 25 AND Cliente.edad <= 35 THEN '25 - 35'
        WHEN Cliente.edad > 35 AND Cliente.edad <= 50 THEN '35 - 50'
        ELSE '> 50'
    END AS rango_etario,
    AVG(Venta.monto_total / Venta.cuotas) AS promedio_importe_cuota
FROM
    BI_Venta AS Venta
    JOIN BI_Cliente AS Cliente ON Venta.id_cliente = Cliente.id_cliente
WHERE
    Venta.cuotas > 1
GROUP BY
    CASE
        WHEN Cliente.edad < 25 THEN '< 25'
        WHEN Cliente.edad >= 25 AND Cliente.edad <= 35 THEN '25 - 35'
        WHEN Cliente.edad > 35 AND Cliente.edad <= 50 THEN '35 - 50'
        ELSE '> 50'
    END;
GO
----- 
-- 12) Vista para calcular el porcentaje de descuento aplicado por cada medio de pago en función del valor de total de pagos sin el descuento, por cuatrimestre.
----- 
CREATE VIEW BI_Porcentaje_Descuento_Medio_Pago AS
SELECT
    Medio_Pago.medio_pago,
    YEAR(Venta.fecha_venta) AS año,
    DATEPART(QUARTER, Venta.fecha_venta) AS cuatrimestre,
    (SUM(Venta.descuento) / (SUM(Venta.monto_total) + SUM(Venta.descuento))) * 100 AS porcentaje_descuento
FROM
    BI_Venta AS Venta
    JOIN BI_Medio_Pago AS Medio_Pago ON Venta.id_medio_pago = Medio_Pago.id_medio_pago
GROUP BY
    Medio_Pago.medio_pago,
    YEAR(Venta.fecha_venta),
    DATEPART(QUARTER, Venta.fecha_venta);
GO
