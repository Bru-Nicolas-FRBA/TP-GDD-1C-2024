	------------------------------------------------------------ Borramos todas las tablas
/*
if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Regla_x_Promocion') begin DROP TABLE REYES_DE_DATOS.Regla_x_Promocion; end
if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Promocion_X_Producto') begin DROP TABLE REYES_DE_DATOS.Promocion_X_Producto; end
if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Promocion_X_Item_Ticket')begin DROP TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Ticket_X_Pago') begin DROP TABLE REYES_DE_DATOS.Ticket_X_Pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Pago') begin DROP TABLE REYES_DE_DATOS.Pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Item_Ticket') begin DROP TABLE REYES_DE_DATOS.Item_Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Envio') begin DROP TABLE REYES_DE_DATOS.Envio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Ticket') begin DROP TABLE REYES_DE_DATOS.Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Producto') begin DROP TABLE REYES_DE_DATOS.Producto; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Empleado') begin DROP TABLE REYES_DE_DATOS.Empleado; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Cliente') begin DROP TABLE REYES_DE_DATOS.Cliente; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Sucursal') begin DROP TABLE REYES_DE_DATOS.Sucursal; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Domicilio') begin DROP TABLE REYES_DE_DATOS.Domicilio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Caja') begin DROP TABLE REYES_DE_DATOS.Caja; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Promocion') begin DROP TABLE REYES_DE_DATOS.Promocion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Localidad') begin DROP TABLE REYES_DE_DATOS.Localidad; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Provincia') begin DROP TABLE REYES_DE_DATOS.Provincia; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_Comprobante') begin DROP TABLE REYES_DE_DATOS.Tipo_Comprobante; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_Caja') begin DROP TABLE REYES_DE_DATOS.Tipo_Caja; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Supermercado') begin DROP TABLE REYES_DE_DATOS.Supermercado; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Regla') begin DROP TABLE REYES_DE_DATOS.Regla; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Descuento') begin DROP TABLE REYES_DE_DATOS.Descuento; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_medio_de_pago') begin DROP TABLE REYES_DE_DATOS.Tipo_medio_de_pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Producto_marca') begin DROP TABLE REYES_DE_DATOS.Producto_marca; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Producto_subcategoria')begin DROP TABLE REYES_DE_DATOS.Producto_subcategoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'Producto_categoria') begin DROP TABLE REYES_DE_DATOS.Producto_categoria; end
GO
*/
------------------------------------------------------------ Borramos todas las vistas
IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Ticket_Promedio_Mensual', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Ticket_Promedio_Mensual; END
GO

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
CREATE TABLE BI_REYES_DE_DATOS.BI_Ubicacion( -- == Domicilio
	id_ubicacion INT PRIMARY KEY IDENTITY(1,1),
	id_provincia INT NOT NULL,
	id_localidad INT NOT NULL,
	direccion varchar(70) not null
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
	rango_etario_inicio int NOT NULL,
	rango_etario_final int not null 
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_turno(
    id_turno INT PRIMARY KEY IDENTITY(1,1),
    turno_inicio TIME NOT NULL,
	turno_final TIME NOT NULL
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
    cliente_nombre VARCHAR(20) not null,
    cliente_apellido VARCHAR(20) not null,
	cliente_id_domicilio int not null,
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    --empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE,
    empleado_fecha_nacimiento DATE,
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
CREATE TABLE BI_REYES_DE_DATOS.BI_Ticket
 (
    id_ticket INT PRIMARY KEY IDENTITY(1,1),
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
    id_ticket int not null,
	id_cliente INT NOT NULL,
    envio_fecha_programada DATETIME NULL,
    --envio_horario_inicio INT NOT NULL,
    --envio_horario_fin INT NOT NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    --envio_estado VARCHAR(50) NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
/*Ticket*/
CREATE TABLE BI_REYES_DE_DATOS.BI_Venta(
    id_venta INT PRIMARY KEY IDENTITY(1,1),
	id_ticket int not null,
	venta_numero INT NOT NULL,
	venta_id_tipo_comprobante INT NOT NULL,
    venta_id_sucursal INT NOT NULL,
    venta_id_caja INT NOT NULL,
    venta_id_empleado INT NOT NULL,
    ticket_fecha_hora DATE NOT NULl,
    venta_total DECIMAL(10, 2) NOT NULL,
    ticket_total_descuento_aplicado DECIMAL(10, 2),
	ticket_total_descuento_aplicado_mp DECIMAL(10, 2),
    ticket_monto_total_envio DECIMAL(10, 2)
);
------------------------------------------------------------------------------------------------
----- CONSTRAINTS CLAVES PRIMARIAS Y FORANEAS -----
------------------------------------------------------------------------------------------------

ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_tipo_comprobante_hechos_venta FOREIGN KEY (id_tipo_comprobante) REFERENCES BI_REYES_DE_DATOS.BI_Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_sucursal_hechos_venta FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_caja_hechos_venta FOREIGN KEY (id_caja) REFERENCES BI_REYES_DE_DATOS.BI_Caja(id_caja)
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_empleado_hechos_venta FOREIGN KEY (id_empleado) REFERENCES BI_REYES_DE_DATOS.BI_Empleado(id_empleado)

ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket
 ADD CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES BI_REYES_DE_DATOS.BI_Producto(id_producto)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket
 ADD CONSTRAINT FK_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES BI_REYES_DE_DATOS.BI_Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket
 ADD CONSTRAINT FK_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket
 ADD CONSTRAINT FK_id_promocion FOREIGN KEY (id_promocion) REFERENCES BI_REYES_DE_DATOS.BI_Promocion(id_promo)

ALTER TABLE BI_REYES_DE_DATOS.BI_Envio ADD CONSTRAINT FK_id_cliente_envio FOREIGN KEY (id_cliente) REFERENCES BI_REYES_DE_DATOS.BI_Cliente(id_cliente)
ALTER TABLE BI_REYES_DE_DATOS.BI_Envio ADD CONSTRAINT FK_id_ticket_envio FOREIGN KEY (id_ticket) REFERENCES BI_REYES_DE_DATOS.BI_Ticket(id_ticket)

ALTER TABLE BI_REYES_DE_DATOS.BI_Producto ADD CONSTRAINT FK_id_producto_categoria FOREIGN KEY (id_producto_categoria) REFERENCES BI_REYES_DE_DATOS.BI_Producto_categoria(id_producto_categoria)
ALTER TABLE BI_REYES_DE_DATOS.BI_Producto ADD CONSTRAINT FK_id_producto_subcategoria FOREIGN KEY (id_producto_subcategoria) REFERENCES BI_REYES_DE_DATOS.BI_Producto_subcategoria(id_producto_subcategoria)

ALTER TABLE BI_REYES_DE_DATOS.BI_Empleado ADD CONSTRAINT FK_id_sucursal_empleado FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)

ALTER TABLE BI_REYES_DE_DATOS.BI_Cliente ADD CONSTRAINT FK_cliente_id_domicilio FOREIGN KEY (cliente_id_domicilio) REFERENCES BI_REYES_DE_DATOS.BI_Ubicacion(id_ubicacion)

GO

----- ----- ----- ----- ----- ----
-----  CREACIÓN DE FUNCIONES -----
----- ----- ----- ----- ----- ----- 
------------------------------------------------------------ Turno
CREATE FUNCTION BI_REYES_DE_DATOS.turno(@fecha_hora DATETIME)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @turno VARCHAR(50);
    SELECT @turno = 
        CASE 
            WHEN @fecha_hora >= CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 08:00:00' AS DATETIME) AND @fecha_hora < CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 12:00:00' AS DATETIME) THEN '8 a 12'
            WHEN @fecha_hora >= CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 12:00:00' AS DATETIME) AND @fecha_hora < CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 16:00:00' AS DATETIME) THEN '12 a 16'
            WHEN @fecha_hora >= CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 16:00:00' AS DATETIME) AND @fecha_hora < CAST(CONVERT(VARCHAR, @fecha_hora, 112) + ' 20:00:00' AS DATETIME) THEN '16 a 20'
            ELSE 'Fuera de turno'
        END;
    RETURN @turno;
END;
GO
------------------------------------------------------------ Rango Etario
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
------------------------------------------------------------ Cuatrimestre
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
INSERT INTO BI_REYES_DE_DATOS.BI_Tiempo(
	anio,
	cuatrimestre,
	mes
)	
SELECT DISTINCT 
	YEAR(pago_fecha),
	BI_REYES_DE_DATOS.cuatrimestre(MONTH(pago_fecha)),
	MONTH(pago_fecha)
FROM REYES_DE_DATOS.Pago
INSERT INTO BI_REYES_DE_DATOS.BI_Tiempo(
	anio,
	cuatrimestre,
	mes
)	
SELECT DISTINCT 
	YEAR(envio_fecha_entrega),
	BI_REYES_DE_DATOS.cuatrimestre(MONTH(envio_fecha_entrega)),
	MONTH(envio_fecha_entrega)
FROM REYES_DE_DATOS.Envio
PRINT 'Migración de BI_Tiempo terminada';
GO
------------------------------------------------------------ Ubicacion
INSERT INTO BI_REYES_DE_DATOS.BI_Ubicacion(
	id_provincia,
	id_localidad,
	direccion
)
SELECT
	d.id_provincia,
	d.id_localidad,
	d.domicilio_direccion
FROM REYES_DE_DATOS.Domicilio d
PRINT 'Migración de BI_ubicación terminada'
GO
------------------------------------------------------------  Sucursal
INSERT INTO BI_REYES_DE_DATOS.BI_Sucursal(
	--sucursal_id_supermercado INT NOT NULL,
    sucursal_domicilio,
    sucursal_numero -- solo el numero
)
SELECT
	--sucursal_id_supermercado,
    sucursal_domicilio,
    sucursal_numero
FROM REYES_DE_DATOS.Sucursal
PRINT 'Migración de BI_Sucursal terminada'
GO
------------------------------------------------------------ Rango Etario
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario_inicio, rango_etario_final) VALUES (1,0,24)
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario_inicio, rango_etario_final) VALUES (2,25,34)
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario_inicio, rango_etario_final) VALUES (3,35,49)
INSERT INTO BI_REYES_DE_DATOS.BI_Rango_Etario (id_rango_etario, rango_etario_inicio, rango_etario_final) VALUES (4,50,100)
PRINT 'Migración de BI_rango_etario terminada';
GO
------------------------------------------------------------ Turno
/*
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno_inicio, turno_final) VALUES ('08:00:00', '12:00:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno_inicio, turno_final) VALUES ('12:00:00', '16:00:00')
INSERT INTO BI_REYES_DE_DATOS.BI_turno (turno_inicio, turno_final) VALUES ('16:00:00', '20:00:00')
PRINT 'Migración de BI_turno terminada'
GO
*/
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
    cliente_apellido,
	cliente_id_domicilio
)
SELECT
	cliente_nombre,
    cliente_apellido,
	c.cliente_id_domicilio
FROM REYES_DE_DATOS.Cliente c;
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
------------------------------------------------------------ Ticket / Venta -- TITO
INSERT INTO BI_REYES_DE_DATOS.BI_Venta(
	id_ticket,
	venta_numero,
	venta_id_tipo_comprobante,
    venta_id_sucursal,
    venta_id_caja,
    venta_id_empleado,
    ticket_fecha_hora,
    venta_total,
    ticket_total_descuento_aplicado,
	ticket_total_descuento_aplicado_mp,
    ticket_monto_total_envio
)
SELECT
	t.id_ticket,
	ticket_numero, -- TICKET_NUMERO
    id_tipo_comprobante,
    id_sucursal,
    id_caja,
    id_empleado,
    ticket_fecha_hora,
    ticket_subtotal,
    ticket_total,
    t.ticket_total_descuento_aplicado,
	ticket_total_descuento_aplicado_mp,
    ticket_monto_total_envio
FROM REYES_DE_DATOS.Ticket t;
PRINT 'Migración de BI_Venta terminada'
GO
------------------------------------------------------------ Envio
INSERT INTO BI_REYES_DE_DATOS.BI_Envio (
    id_ticket,
    id_cliente,
    envio_fecha_programada,
    --envio_horario_inicio INT NOT NULL,
    --envio_horario_fin INT NOT NULL,
    envio_fecha_entrega,
    --envio_estado VARCHAR(50) NOT NULL,
    envio_costo
)
SELECT
	e.id_ticket
    id_cliente,
    envio_fecha_programada,
    --envio_horario_inicio,
    --envio_horario_fin,
    envio_fecha_entrega,
    --envio_estado,
    envio_costo
FROM REYES_DE_DATOS.Envio e
PRINT 'Migración de BI_Envio terminada'
GO
------------------------------------------------------------ Promocion
INSERT INTO BI_REYES_DE_DATOS.BI_Promocion(
	id_promo,
	promo_descripcion
	--promo_fecha_inicio DATETIME NOT NULL,
	--promo_fecha_fin DATETIME NOT NULL,
)
SELECT
	id_promo,
	promo_descripcion
FROM REYES_DE_DATOS.Promocion
PRINT 'Migración de BI_Promo terminada'
GO
------------------------------------------------------------ Empleado
INSERT INTO BI_REYES_DE_DATOS.BI_Empleado (
    id_sucursal,
    empleado_nombre,
    empleado_apellido,
    --empleado_dni INT NOT NULL,
    empleado_fecha_registro,
    empleado_fecha_nacimiento
    --empleado_email VARCHAR(30) NOT NULL,
    --empleado_telefono DECIMAL(8, 0) NOT NULL
)
SELECT
	id_sucursal,
    empleado_nombre,
    empleado_apellido,
    --empleado_dni INT NOT NULL,
    empleado_fecha_registro,
	empleado_fecha_nacimiento
FROM REYES_DE_DATOS.Empleado
PRINT 'Migración de BI_Empleado terminada'
GO
------------------------------------------------------------ Item Ticket
INSERT INTO BI_REYES_DE_DATOS.BI_Ticket
(
    --id_item_ticket INT PRIMARY KEY IDENTITY(1,1),
    ticket_numero,
    id_sucursal,
    id_tipo_comprobante,
    id_producto,
    id_promocion,
    item_ticket_cantidad,
    item_ticket_precio
)
SELECT
	ticket_numero,
    id_sucursal,
    id_tipo_comprobante,
    id_producto,
    id_promocion,
    item_ticket_cantidad,
    item_ticket_precio
FROM REYES_DE_DATOS.Item_Ticket t
PRINT 'Migración de BI_Ticket terminada'
GO
----- ----- ----- ----- ----- 
----- CREACION DE HECHOS ----- 
----- ----- ----- ----- -----
------------------------------------------------------------ hechos venta tiempo
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_venta_tiempo (
	id_venta INT,
    ticket_fecha_hora DATETIME,
    envio_fecha_entrega DATE,
    id_tiempo INT FOREIGN KEY (id_tiempo) REFERENCES BI_REYES_DE_DATOS.BI_Tiempo(id_tiempo)
);

INSERT INTO BI_REYES_DE_DATOS.BI_hechos_venta_tiempo (
	id_venta,
    ticket_fecha_hora,
    envio_fecha_entrega,
    id_tiempo
)
SELECT
    v.id_venta,
    v.ticket_fecha_hora,
    e.envio_fecha_entrega,
    t.id_tiempo
FROM BI_REYES_DE_DATOS.BI_Venta v
	JOIN BI_REYES_DE_DATOS.BI_Envio e ON v.id_ticket = e.id_ticket
	JOIN BI_REYES_DE_DATOS.BI_tiempo t ON YEAR(v.ticket_fecha_hora) = t.anio 
		AND MONTH(v.ticket_fecha_hora) = t.mes
		AND 
			CASE 
				WHEN MONTH(v.ticket_fecha_hora) IN (1, 2, 3, 4) THEN 1
				WHEN MONTH(v.ticket_fecha_hora) IN (5, 6, 7, 8) THEN 2
				WHEN MONTH(v.ticket_fecha_hora) IN (9, 10, 11, 12) THEN 3
			END = t.cuatrimestre;
PRINT 'Migración de BI_hechos_venta_tiempo terminada'
GO
------------------------------------------------------------ hechos venta ubicacion
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion (
    id_venta INT PRIMARY KEY FOREIGN KEY (id_venta) REFERENCES BI_REYES_DE_DATOS.BI_Venta(id_venta),
    id_ubicacion INT FOREIGN KEY (id_ubicacion) REFERENCES BI_REYES_DE_DATOS.BI_Ubicacion(id_ubicacion),
    id_provincia INT NOT NULL,
    id_localidad INT NOT NULL,
);
INSERT INTO BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion (
    id_venta,
    id_ubicacion,
    id_provincia,
    id_localidad
)
SELECT
    v.id_venta,
    u.id_ubicacion,
    u.id_provincia,
    u.id_localidad
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_Sucursal s on v.venta_id_sucursal = s.id_sucursal
	join BI_REYES_DE_DATOS.BI_Ubicacion u on s.sucursal_domicilio = u.direccion
PRINT 'Migración de BI_hechos_venta_ubicacion terminada'
GO
----- ----- ----- ----- ----- 
----- CREACION DE VIEWS ----- 
----- ----- ----- ----- ----- 
/*
Bru		1-5-9
Martin	2-6-10
Alan	3-7-11
Carmen	4-8-12
*/
----- 
-- 1) Vista para calcular el ticket promedio mensual por localidad, año y mes
-----
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual; END
GO

CREATE VIEW BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual AS
SELECT
    AVG(v.venta_total) AS PromedioMensual,
    l.localidad_nombre,
    t.anio AS Año,
    t.mes AS Mes
FROM BI_REYES_DE_DATOS.BI_Venta v
	JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON v.id_venta = vt.id_venta
	JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON vt.id_tiempo = t.id_tiempo
	JOIN BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion vu ON v.id_venta = vu.id_venta
	JOIN BI_REYES_DE_DATOS.BI_Ubicacion u ON vu.id_ubicacion = u.id_ubicacion
	join REYES_DE_DATOS.Localidad l on u.id_localidad = l.id_localidad
GROUP BY
    t.mes,
    t.anio,
    u.id_localidad;
GO
----- 
-- 5) Vista para calcular el porcentaje de descuento aplicados en función del total de los tickets según el mes de cada año
----- 
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes; END
GO

CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes AS
SELECT
	t.anio as Año,
	t.mes as Mes,
	(count(distinct v.ticket_total_descuento_aplicado) * 100) / (count (distinct v.id_venta)) as Porcentaje
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt on v.id_ticket = vt.id_venta
	join BI_REYES_DE_DATOS.BI_Tiempo t on vt.id_tiempo = t.id_tiempo
GROUP BY
	t.anio,
	t.mes
ORDER BY
	t.anio desc,
	t.mes desc
GO
----- 
-- 9) Vista para calcular las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.
----- 
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio; END GO

CREATE VIEW BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio AS
SELECT TOP 5
    c.id_cliente as Cliente,
    l.localidad_nombre as Localidad,
    sum(e.envio_costo) as CostoEnvio
FROM BI_REYES_DE_DATOS.BI_Envio e
	JOIN BI_REYES_DE_DATOS.BI_Cliente c on e.id_cliente = c.id_cliente
	JOIN BI_REYES_DE_DATOS.BI_Ubicacion u on c.cliente_id_domicilio = u.id_ubicacion
	JOIN REYES_DE_DATOS.Localidad l on u.id_localidad = l.id_localidad
GROUP BY
    c.id_cliente,
	l.localidad_nombre
ORDER BY
    sum(e.envio_costo) DESC;
GO
----- 
-- 2) Vista para calcular la cantidad de unidades promedio por turno para cada cuatrimestre de cada año
----- 
IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio; END GO

CREATE VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio AS
SELECT
	--promedio cantidad unidades
	avg(t.item_ticket_cantidad) as Promedio,
	--para cada turno
	BI_REYES_DE_DATOS.turno(v.ticket_fecha_hora) as Turno,
    --para cada cuatrimestre
	tmp.cuatrimestre as Cuatrimestre,
    --para cada anio
	tmp.anio as Año
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt on v.id_venta = vt.id_tiempo
	join BI_REYES_DE_DATOS.BI_Tiempo tmp on vt.id_tiempo = tmp.id_tiempo
	join BI_REYES_DE_DATOS.BI_Ticket t on t.id_item_ticket = v.id_ticket
GROUP BY
	2,
	tmp.cuatrimestre,
	tmp.anio
GO
----- 
-- 6) Vista para calcular las tres categorías de productos con mayor descuento aplicado a partir de promociones para cada cuatrimestre de cada año.
-----

IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento; END GO

CREATE VIEW BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento AS
SELECT top 3
	--t.anio AS anio,
	t.anio as Anio,
    --t.cuatrimest,re AS cuatrimestre,
	t.cuatrimestre as Cuatrimestre,
    --categoria
	pc.producto_categoria_detalle as Categoria,
    --productos con mayor descuento aplicado a partir de promociones
	sum(v.ticket_total_descuento_aplicado) as DescuentoAplicado
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt on v.id_ticket = vt.id_venta
	join BI_REYES_DE_DATOS.BI_Tiempo t on vt.id_tiempo = t.id_tiempo
	join BI_REYES_DE_DATOS.BI_Ticket tck on v.id_ticket = tck.id_item_ticket
	join BI_REYES_DE_DATOS.BI_Producto p on tck.id_producto = p.id_producto
	join BI_REYES_DE_DATOS.BI_Producto_categoria pc on p.id_producto_categoria = pc.id_producto_categoria
WHERE v.ticket_total_descuento_aplicado IS NOT NULL
GROUP BY
    t.anio,
	t.cuatrimestre,
	pc.id_producto_categoria
ORDER BY 
	sum(v.ticket_total_descuento_aplicado) desc;
GO
----- 
-- 10) Vista para calcular las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de pago, mes y año.
----- 

IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas', 'V') IS NOT NULL 
BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas; END GO


CREATE VIEW BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas AS
SELECT TOP 3
    --Sucursal.nombre AS nombre_sucursal,
    --Medio_Pago.nombre AS nombre_medio_pago,
    --YEAR(Venta.fecha_venta) AS año,
    --MONTH(Venta.fecha_venta) AS mes,
    --SUM(Venta.monto_total) AS total_pagos_cuotas
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_Sucursal s on v.venta_id_sucursal = s.id_sucursal
	join BI_REYES_DE_DATOS.BI_Ticket tk on v.id_ticket = tk.id_item_ticket
	join BI_REYES_DE_DATOS.BI_medio_de_pago mp on tk. 
WHERE

GROUP BY

ORDER BY
    SUM(Venta.monto_total) DESC;
GO
----- ----- ----- -----
----- OTRAS VIEWS -----
----- ----- ----- -----
----- 
-- 3) REVISAR Vista para calcular porcentaje anual de ventas registradas por rango etario del empleado según el tipo de caja para cada cuatrimestre.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre AS
SELECT
    BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento) as RangoEtario,
    c.caja_tipo as TipoCaja,
    t.cuatrimestre as Cuatrimestre,
    (SUM(v.venta_total) * 100) / (SELECT SUM(v2.venta_total)
                                  FROM BI_REYES_DE_DATOS.BI_Venta v2
                                  JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt2 ON v2.id_ticket = vt2.id_venta
                                  JOIN BI_REYES_DE_DATOS.BI_Tiempo t2 ON vt2.id_tiempo = t2.id_tiempo
                                  WHERE t2.anio = t.anio) as Porcentaje

FROM 
    BI_REYES_DE_DATOS.BI_Venta v
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON v.id_ticket = vt.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON vt.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Caja c ON c.id_caja = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Empleado e ON v.id_empleado = e.id_empleado
GROUP BY
    BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento),
    c.caja_tipo,
    t.cuatrimestre,
    t.anio
ORDER BY
    RangoEtario,
    TipoCaja,
    Cuatrimestre
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
-- 7) Vista para calcular porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios AS
SELECT
    s.id_sucursal AS Sucursal,
    t.anio AS Año,
    t.mes AS Mes,
    t.cuatrimestre AS Cuatrimestre,
    (COUNT(CASE 
        WHEN e.envio_fecha_entrega <= e.envio_fecha_programada THEN 1 
        ELSE NULL 
    END) * 100.0) / COUNT(e.id_envio) AS PorcentajeDeCumplimiento
FROM 
    BI_REYES_DE_DATOS.BI_Envio e
    JOIN BI_REYES_DE_DATOS.BI_Venta v ON e.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Sucursal s ON v.id_sucursal = s.id_sucursal
GROUP BY
    s.id_sucursal,
    t.anio,
    t.mes,
    t.cuatrimestre
ORDER BY
    s.id_sucursal,
    t.anio,
    t.mes,
    t.cuatrimestre
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
