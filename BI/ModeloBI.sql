--cosas para corregir
/*

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
	id_sucursal INT PRIMARY KEY IDENTITY(1,1),
	sucursal_id_supermercado INT NOT NULL,
    sucursal_domicilio VARCHAR(100) NOT NULL,
    sucursal_numero VARCHAR(50) NOT NULL -- solo el numero
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
CREATE TABLE BI_REYES_DE_DATOS.BI_medio_de_pago(
    id_medio_de_pago INT PRIMARY KEY IDENTITY(1,1),
	medio_de_pago_clasificacion VARCHAR(100) NOT NULL, -- credito / debito / efectivo / etc
	medio_de_pago_detalle VARCHAR(100) NOT NULL,
);
CREATE TABLE BI_REYES_DE_DATOS.BI_Producto_categoria (
	id_producto_categoria INT PRIMARY KEY IDENTITY(1,1),
	producto_categoria_detalle VARCHAR(50) NOT NULL,
);
---
CREATE TABLE BI_REYES_DE_DATOS.BI_Producto_subcategoria (
	id_producto_subcategoria INT PRIMARY KEY IDENTITY(1,1),
	producto_subcategoria_detalle VARCHAR(50) NOT NULL,
);
----- ----- ----- ----- ----- ----- 
----- TABLAS ADICIONALES -----
----- ----- ----- ----- ----- -----
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Caja(
	id_caja INT PRIMARY KEY IDENTITY(1,1),
	caja_numero INT NOT NULL,
	caja_tipo VARCHAR(30) NOT NULL, 
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Descuento (
	descuento_codigo INT PRIMARY KEY NOT NULL,
	descuento_descripcion VARCHAR(100) NOT NULL,
	descuento_fecha_inicio DATE NOT NULL,
	descuento_fecha_fin DATE NOT NULL,
	descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
	descuento_tope DECIMAL(10, 2) NOT NULL,
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    cliente_nombre VARCHAR(100),
    cliente_apellido VARCHAR(100)    
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    --empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE,
    --empleado_fecha_nacimiento DATE,
    --empleado_email VARCHAR(30) NOT NULL,
    --empleado_telefono DECIMAL(8, 0) NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Producto (
    id_producto INT PRIMARY KEY IDENTITY(1,1),
	producto_codigo NVARCHAR(100) NOT NULL, -- PRODUCTO_NOMBRE
    id_producto_categoria INT NOT NULL,
    id_producto_subcategoria INT NOT NULL,
    --id_marca INT NOT NULL,
    --producto_descripcion NVARCHAR(100) NOT NULL,
    producto_precio DECIMAL(10, 2) NOT NULL   
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Promocion(
	id_promo INT PRIMARY KEY NOT NULL,
	promo_descripcion VARCHAR(50) NOT NULL,
	--promo_fecha_inicio DATETIME NOT NULL,
	--promo_fecha_fin DATETIME NOT NULL,
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Ticket (
    id_item_ticket INT PRIMARY KEY IDENTITY(1,1),
    ticket_numero VARCHAR(50) NOT NULL,
    id_sucursal INT NOT NULL,
    id_tipo_comprobante INT NOT NULL,
    id_producto INT NOT NULL,
    id_promocion INT,
    item_ticket_cantidad INT NOT NULL,
    item_ticket_precio INT NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Envio (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
    id_ticket INT NOT NULL,
    id_cliente INT NOT NULL,
    envio_fecha_programada DATETIME NULL,
    --envio_horario_inicio INT NOT NULL,
    --envio_horario_fin INT NOT NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    --envio_estado VARCHAR(50) NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
----- ----- ----- ----- ----- ----- -----
-----  CREACIÓN DE TABLAS-HECHOS ----- 
----- ----- ----- ----- ----- ----- ----
-----
/*Ticket*/
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_Venta(
    id_ticket INT PRIMARY KEY IDENTITY(1,1),
	ticket_numero INT NOT NULL, -- TICKET_NUMERO
    id_tipo_comprobante INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_caja INT NOT NULL,
    id_empleado INT NOT NULL,
    ticket_fecha_hora DATE NOT NULL,
    ticket_subtotal DECIMAL(10, 2) NOT NULL,
    venta_total DECIMAL(10, 2) NOT NULL,
    ticket_total_descuento_aplicado INT NOT NULL,
	ticket_total_descuento_aplicado_mp INT NOT NULL,
    ticket_monto_total_envio INT NOT NULL
);
GO

CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_descuento_venta(
	id_tipo_descuento INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_Descuento(descuento_codigo) NOT NULL,
	id_venta INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_hechos_ventas(id_venta) NOT NULL,
	total DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_envios(
	id_envio INT PRIMARY KEY IDENTITY(1,1),
	id_ubicacion INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_Ubicacion(id_ubicacion) NOT NULL,
	id_tiempo INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_tiempo(id_tiempo) NOT NULL,
	cantidad_envios INT NOT NULL,
);
GO

CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_producto_venta(
	id_producto_venta INT PRIMARY KEY IDENTITY(1,1),
	id_producto INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_producto(id_producto) NOT NULL,
	id_categoria_producto INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_Producto_categoria(id_producto_categoria) NOT NULL,
	id_subcategoria_producto INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_Producto_subcategoria(id_producto_subcategoria) NOT NULL,
	id_tiempo INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_tiempo(id_tiempo) NOT NULL,
	id_rango_etario INT FOREIGN KEY REFERENCES BI_REYES_DE_DATOS.BI_rango_etario(id_rango_etario) NOT NULL,
	monto_total INT NOT NULL,
	cantidad INT NOT NULL,
);
GO

/*ver que combinacion se repite ej: ventas-tiempo yqs tengo suenio la concha de tu madre*/

------------------------------------------------------------------------------------------------
----- CONSTRAINTS CLAVES PRIMARIAS Y FORANEAS -----
------------------------------------------------------------------------------------------------

ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_Venta ADD CONSTRAINT FK_id_tipo_comprobante_hechos_venta FOREIGN KEY (id_tipo_comprobante) REFERENCES BI_REYES_DE_DATOS.BI_Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_Venta ADD CONSTRAINT FK_id_sucursal_hechos_venta FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_Venta ADD CONSTRAINT FK_id_caja_hechos_venta FOREIGN KEY (id_caja) REFERENCES BI_REYES_DE_DATOS.BI_Caja(id_caja)
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_Venta ADD CONSTRAINT FK_id_empleado_hechos_venta FOREIGN KEY (id_empleado) REFERENCES BI_REYES_DE_DATOS.BI_Empleado(id_empleado)

ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES BI_REYES_DE_DATOS.BI_Producto(id_producto)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES BI_REYES_DE_DATOS.BI_Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_promocion FOREIGN KEY (id_promocion) REFERENCES BI_REYES_DE_DATOS.BI_Promocion(id_promo)

ALTER TABLE BI_REYES_DE_DATOS.BI_Envio ADD CONSTRAINT FK_id_cliente_envio FOREIGN KEY (id_cliente) REFERENCES BI_REYES_DE_DATOS.BI_Cliente(id_cliente)


ALTER TABLE BI_REYES_DE_DATOS.BI_Producto ADD CONSTRAINT FK_id_producto_categoria FOREIGN KEY (id_producto_categoria) REFERENCES BI_REYES_DE_DATOS.BI_Producto_categoria(id_producto_categoria)
ALTER TABLE BI_REYES_DE_DATOS.BI_Producto ADD CONSTRAINT FK_id_producto_subcategoria FOREIGN KEY (id_producto_subcategoria) REFERENCES BI_REYES_DE_DATOS.BI_Producto_subcategoria(id_producto_subcategoria)

ALTER TABLE BI_REYES_DE_DATOS.BI_Empleado ADD CONSTRAINT FK_id_sucursal_empleado FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)

ALTER TABLE BI_REYES_DE_DATOS.BI_Cliente ADD CONSTRAINT FK_cliente_id_domicilio FOREIGN KEY (cliente_id_domicilio) REFERENCES BI_REYES_DE_DATOS.BI_Domicilio(id_domicilio)
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
------------------------------------------------------------ Tiempo
INSERT INTO BI_REYES_DE_DATOS.BI_tiempo(
	anio,
	cuatrimestre,
	mes
)	
SELECT DISTINCT 
	YEAR(pago_fecha),
	BI_REYES_DE_DATOS.cuatrimestre(MONTH(pago_fecha)),
	MONTH(pago_fecha)
FROM REYES_DE_DATOS.Pago
INSERT INTO BI_REYES_DE_DATOS.BI_tiempo(
	anio,
	cuatrimestre,
	mes
)	
SELECT DISTINCT 
	YEAR(envio_fecha_entrega),
	BI_REYES_DE_DATOS.cuatrimestre(MONTH(envio_fecha_entrega)),
	MONTH(envio_fecha_entrega)
FROM REYES_DE_DATOS.Envio
PRINT 'Migración de BI_tiempo terminada';
------------------------------------------------------------ Ubicacion
INSERT INTO BI_REYES_DE_DATOS.BI_Ubicacion(
	id_provincia,
	id_localidad
)
SELECT
	p.id_provincia, 
	l.id_localidad
FROM REYES_DE_DATOS.Provincia p
	CROSS JOIN REYES_DE_DATOS.Localidad l
PRINT 'Migración de BI_ubicación terminada'
------------------------------------------------------------  Sucursal
INSERT INTO BI_REYES_DE_DATOS.BI_Sucursal(
	--sucursal_id_supermercado INT NOT NULL,
    sucursal_domicilio VARCHAR(100) NOT NULL,
    sucursal_numero VARCHAR(50) NOT NULL -- solo el numero
SELECT
	--sucursal_id_supermercado,
    sucursal_domicilio,
    sucursal_numero
FROM REYES_DE_DATOS.Sucursal
PRINT 'Migración de BI_Sucursal terminada'
------------------------------------------------------------ Rango Etario
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (1, '<25')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (2, '25-34')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (3, '35-50')
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario) VALUES (4, '<50')
PRINT 'Migración de BI_rango_etario terminada';
------------------------------------------------------------ Turno
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('08:00 - 12:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('12:00 - 16:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno) VALUES ('16:00 - 20:00')
PRINT 'Migración de BI_turno terminada'
------------------------------------------------------------ Medio De Pago
INSERT INTO BI_REYES_DE_DATOS.BI_medio_de_pago(
    medio_de_pago_clasificacion, -- credito / debito / efectivo / etc
	medio_de_pago_detalle
)
SELECT
	medio_de_pago_clasificacion, -- credito / debito / efectivo / etc
	medio_de_pago_detalle
FROM REYES_DE_DATOS.Tipo_medio_de_pago
PRINT 'Migración de BI_medio_de_pago terminada'
GO
------------------------------------------------------------ Categoria Producto 
INSERT INTO BI_REYES_DE_DATOS.BI_Producto_categoria(
	producto_categoria_detalle
)
SELECT
	producto_categoria_detalle
FROM REYES_DE_DATOS.Producto_categoria
PRINT 'Migración de BI_categoria_producto terminada'
GO
------------------------------------------------------------ Subcategoria Producto
INSERT INTO BI_REYES_DE_DATOS.BI_Producto_subcategoria(
	producto_subcategoria_detalle
)
SELECT
	producto_subcategoria_detalle
FROM REYES_DE_DATOS.Producto_subcategoria
PRINT 'Migración de BI_categoria_subproducto terminada'
GO
------------------------------------------------------------ Caja
INSERT INTO BI_REYES_DE_DATOS.BI_Caja(
	caja_numero,
	caja_tipo
)
SELECT
	caja_numero,
	caja_tipo
FROM REYES_DE_DATOS.Caja
PRINT 'Migración de BI_Caja terminada'
GO
------------------------------------------------------------ Descuento
INSERT INTO BI_REYES_DE_DATOS.BI_Descuento (
	descuento_codigo,
	descuento_descripcion,
	descuento_fecha_inicio,
	descuento_fecha_fin,
	descuento_valor_porcentual_a_aplicar,
	descuento_tope
)
SELECT
	descuento_codigo,
	descuento_descripcion,
	descuento_fecha_inicio,
	descuento_fecha_fin,
	descuento_valor_porcentual_a_aplicar,
	descuento_tope
FROM REYES_DE_DATOS.Descuento
PRINT 'Migración de BI_Descuento terminada'
GO
------------------------------------------------------------ Cliente
INSERT INTO BI_REYES_DE_DATOS.BI_Cliente(
    cliente_nombre,
    cliente_apellido  
)
SELECT
	cliente_nombre,
    cliente_apellido
FROM REYES_DE_DATOS.Cliente;
PRINT 'Migración de BI_Cliente terminada'
GO
------------------------------------------------------------ Producto
INSERT INTO BI_REYES_DE_DATOS.BI_Producto(
	producto_codigo, -- PRODUCTO_NOMBRE
    id_producto_categoria,
    id_producto_subcategoria,
    --id_marca INT NOT NULL,
    --producto_descripcion,
    producto_precio
)
SELECT 
	producto_codigo,
    id_producto_categoria,
    id_producto_subcategoria,
    --id_marca,
    --producto_descripcion,
    producto_precio
FROM REYES_DE_DATOS.Producto;
PRINT 'Migración de BI_Producto terminada'
GO
------------------------------------------------------------ Envio
CREATE TABLE BI_REYES_DE_DATOS.BI_Envio (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
    id_ticket INT NOT NULL,
    id_cliente INT NOT NULL,
    envio_fecha_programada DATETIME NULL,
    --envio_horario_inicio INT NOT NULL,
    --envio_horario_fin INT NOT NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    --envio_estado VARCHAR(50) NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
------------------------------------------------------------ Promocion
CREATE TABLE BI_REYES_DE_DATOS.BI_Promocion(
	id_promo INT PRIMARY KEY NOT NULL,
	promo_descripcion VARCHAR(50) NOT NULL,
	--promo_fecha_inicio DATETIME NOT NULL,
	--promo_fecha_fin DATETIME NOT NULL,
);
------------------------------------------------------------ Empleado
CREATE TABLE BI_REYES_DE_DATOS.BI_Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    --empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE,
    --empleado_fecha_nacimiento DATE,
    --empleado_email VARCHAR(30) NOT NULL,
    --empleado_telefono DECIMAL(8, 0) NOT NULL
);
------------------------------------------------------------ Item Ticket
CREATE TABLE BI_REYES_DE_DATOS.BI_Ticket (
    id_item_ticket INT PRIMARY KEY IDENTITY(1,1),
    ticket_numero VARCHAR(50) NOT NULL,
    id_sucursal INT NOT NULL,
    id_tipo_comprobante INT NOT NULL,
    id_producto INT NOT NULL,
    id_promocion INT,
    item_ticket_cantidad INT NOT NULL,
    item_ticket_precio INT NOT NULL
);
GO
------------------------------------------------------------ Ticket / Venta -- TITO
INSERT INTO BI_REYES_DE_DATOS.BI_Venta(
	venta_numero,
	venta_id_tipo_comprobante,
    venta_id_sucursal,
    venta_id_caja,
    venta_id_empleado,
    sticket_fecha_hora,
    venta_total
    --ticket_total_descuento_aplicado,
	--ticket_total_descuento_aplicado_mp,
    --ticket_monto_total_envio
)
SELECT 
	ticket_numero, -- TICKET_NUMERO
    id_tipo_comprobante,
    id_sucursal,
    id_caja,
    id_empleado,
    ticket_fecha_hora,
    ticket_subtotal,
    ticket_total,
    --ticket_total_descuento_aplicado,
	--ticket_total_descuento_aplicado_mp,
    --ticket_monto_total_envio
FROM REYES_DE_DATOS.Ticket;

----- ----- ----- ----- ----- 
----- CREACION DE VIEWS ----- 
----- ----- ----- ----- ----- 
/*
Bru		1-5-9
Martin	2-6-10
Alan	3-7-11
Carmen	4-8-12
*/
----- ----- ----- -----
----- VIEWS BRU -----
----- ----- ----- -----
----- 
-- 1) Vista para calcular el ticket promedio mensual por localidad, año y mes
----- 
CREATE VIEW Vista_Ticket_Promedio_Mensual AS
SELECT
    AVG(it.item_precio_total) AS ticket_promedio
    l.localidad_nombre,
    YEAR(t.ticket_fecha_hora) AS anio,
    MONTH(t.ticket_fecha_hora) AS mes,
FROM
    --kk de aca solo se usa hechos
	--hechos_venta
	--tiempo
	--unibacion
GROUP BY
    MONTH(t.ticket_fecha_hora),
    YEAR(t.ticket_fecha_hora),
    l.localidad_nombre;
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

----- ----- ----- -----
----- OTRAS VIEWS -----
----- ----- ----- -----
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
