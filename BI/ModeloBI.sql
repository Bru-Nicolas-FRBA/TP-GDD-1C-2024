USE [GD1C2024]
GO
----- ----- ----- ----- ----- ----- ----- ----- 
----- BORRAR ----- 
----- ----- ----- ----- ----- ----- ----- ----- 

/*A veces necesitaremos ejecutar "BORRAR" dos veces (todavia no encontre el por qué de esto)*/

------------------------------------------------------------ Tablas 
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_venta_ubicacion') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_venta_tiempo') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_venta_tiempo; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Ticket') begin DROP TABLE BI_REYES_DE_DATOS.BI_Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Producto') begin DROP TABLE BI_REYES_DE_DATOS.BI_Producto; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Producto_subcategoria') begin DROP TABLE BI_REYES_DE_DATOS.BI_Producto_subcategoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Producto_categoria') begin DROP TABLE BI_REYES_DE_DATOS.BI_Producto_categoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Cliente') begin DROP TABLE BI_REYES_DE_DATOS.BI_Cliente; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Descuento') begin DROP TABLE BI_REYES_DE_DATOS.BI_Descuento; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_medio_de_pago') begin DROP TABLE BI_REYES_DE_DATOS.BI_medio_de_pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Rango_Etario')begin DROP TABLE BI_REYES_DE_DATOS.BI_Rango_Etario; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Venta') begin DROP TABLE BI_REYES_DE_DATOS.BI_Venta; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Caja') begin DROP TABLE BI_REYES_DE_DATOS.BI_Caja; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Envio') begin DROP TABLE BI_REYES_DE_DATOS.BI_Envio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Promocion') begin DROP TABLE BI_REYES_DE_DATOS.BI_Promocion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Empleado') begin DROP TABLE BI_REYES_DE_DATOS.BI_Empleado; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_turno') begin DROP TABLE BI_REYES_DE_DATOS.BI_turno; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Sucursal') begin DROP TABLE BI_REYES_DE_DATOS.BI_Sucursal; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Ubicacion') begin DROP TABLE BI_REYES_DE_DATOS.BI_Ubicacion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Tiempo') begin DROP TABLE BI_REYES_DE_DATOS.BI_Tiempo; end
GO
------------------------------------------------------------ Borramos todas las vistas
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual', 'V') IS NOT NULL  BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual; END 
IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre; END
IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Cantidad_Ventas_Por_Turno_Y_Localidad', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Ventas_Por_Turno_Y_Localidad; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes', 'V') IS NOT NULL  BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes; END
IF OBJECT_ID('BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Cantidad_Envios_Rango_Etario', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Cantidad_Envios_Rango_Etario; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Promedio_Importe_Cuota_RangoEtario', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Promedio_Importe_Cuota_RangoEtario; END
IF OBJECT_ID('BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Medio_Pago', 'V') IS NOT NULL BEGIN DROP VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Medio_Pago; END
GO
------------------------------------------------------------ borramos todas las funciones
IF OBJECT_ID('BI_REYES_DE_DATOS.turno', 'FN') IS NOT NULL BEGIN DROP FUNCTION BI_REYES_DE_DATOS.turno; END
IF OBJECT_ID('BI_REYES_DE_DATOS.rangoEtario ', 'FN') IS NOT NULL BEGIN DROP FUNCTION BI_REYES_DE_DATOS.rangoEtario ; END
IF OBJECT_ID('BI_REYES_DE_DATOS.cuatrimestre', 'FN') IS NOT NULL BEGIN DROP FUNCTION BI_REYES_DE_DATOS.cuatrimestre; END
GO
----- ----- ----- ----- ----- ----- ----- ----- 
----- CREACIÓN DE TABLAS-DIMENSIONES ----- 
----- ----- ----- ----- ----- ----- ----- ----- 
------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'BI_REYES_DE_DATOS')
BEGIN EXEC ('CREATE SCHEMA BI_REYES_DE_DATOS') END
GO
------------------------------------------------------------
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
    cliente_nombre VARCHAR(50) not null,
    cliente_apellido VARCHAR(50) not null,
	cliente_id_domicilio int not null,
    cliente_fecha_nacimiento date not null
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    empleado_fecha_nacimiento DATE not null
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Producto (
    id_producto INT PRIMARY KEY,
	producto_codigo NVARCHAR(100) NOT NULL, -- PRODUCTO_NOMBRE
    id_producto_categoria INT NOT NULL,
    id_producto_subcategoria INT NOT NULL,
    producto_precio DECIMAL(10, 2) NOT NULL   
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Promocion(
	id_promo INT PRIMARY KEY NOT NULL,
	promo_descripcion VARCHAR(50) NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Ticket(
    id_ticket INT PRIMARY KEY IDENTITY(1,1),
    ticket_numero VARCHAR(50) NOT NULL,
    id_sucursal INT NOT NULL, 
    id_tipo_comprobante INT NOT NULL,
    id_producto INT NOT NULL,
    item_ticket_cantidad INT NOT NULL,
    item_ticket_precio INT NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Envio (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
    id_ticket int not null,
	id_cliente INT NOT NULL,
    envio_fecha_programada DATETIME NULL,
    envio_horario_inicio INT NOT NULL,
    envio_horario_fin INT NOT NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
----- /*Ticket*/
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
	ticket_monto_total_envio DECIMAL(10, 2)
);
----- hechos
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_venta_tiempo (
	id_venta INT,
    ticket_fecha_hora DATETIME,
    envio_fecha_entrega DATE,
    id_tiempo INT FOREIGN KEY (id_tiempo) REFERENCES BI_REYES_DE_DATOS.BI_Tiempo(id_tiempo)
);
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion (
    id_venta INT PRIMARY KEY FOREIGN KEY (id_venta) REFERENCES BI_REYES_DE_DATOS.BI_Venta(id_venta),
    id_ubicacion INT FOREIGN KEY (id_ubicacion) REFERENCES BI_REYES_DE_DATOS.BI_Ubicacion(id_ubicacion),
    id_provincia INT NOT NULL,
    id_localidad INT NOT NULL,
);
------------------------------------------------------------------------------------------------
----- CONSTRAINTS CLAVES PRIMARIAS Y FORANEAS -----
------------------------------------------------------------------------------------------------
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_sucursal_hechos_venta FOREIGN KEY (venta_id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_caja_hechos_venta FOREIGN KEY (venta_id_caja) REFERENCES BI_REYES_DE_DATOS.BI_Caja(id_caja)
ALTER TABLE BI_REYES_DE_DATOS.BI_Venta ADD CONSTRAINT FK_id_empleado_hechos_venta FOREIGN KEY (venta_id_empleado) REFERENCES BI_REYES_DE_DATOS.BI_Empleado(id_empleado)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES BI_REYES_DE_DATOS.BI_Producto(id_producto)
ALTER TABLE BI_REYES_DE_DATOS.BI_Ticket ADD CONSTRAINT FK_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
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
------------------------------------------------------------  Sucursal
INSERT INTO BI_REYES_DE_DATOS.BI_Sucursal(
	sucursal_domicilio,
    sucursal_numero -- solo el numero
)
SELECT
	sucursal_domicilio,
    sucursal_numero
FROM REYES_DE_DATOS.Sucursal
PRINT 'Migración de BI_Sucursal terminada'
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
	cliente_id_domicilio,
    cliente_fecha_nacimiento
)
SELECT
	cliente_nombre,
    cliente_apellido,
	c.cliente_id_domicilio,
    c.cliente_fecha_nacimiento
FROM REYES_DE_DATOS.Cliente c;
PRINT 'Migración de BI_Cliente terminada'
GO
------------------------------------------------------------ Producto
INSERT INTO BI_REYES_DE_DATOS.BI_Producto(
	id_producto,
	producto_codigo, -- PRODUCTO_NOMBRE
    id_producto_categoria,
    id_producto_subcategoria,
    producto_precio
)
SELECT 
	p.id_producto,
	p.producto_codigo,
    p.id_producto_categoria,
    p.id_producto_subcategoria,
    p.producto_precio
FROM REYES_DE_DATOS.Producto p;
PRINT 'Migración de BI_Producto terminada'
GO
------------------------------------------------------------ Empleado
INSERT INTO BI_REYES_DE_DATOS.BI_Empleado (
    id_sucursal,
    empleado_nombre,
    empleado_apellido,
    empleado_fecha_nacimiento
    
)
SELECT
	id_sucursal,
    empleado_nombre,
    empleado_apellido,
	empleado_fecha_nacimiento
FROM REYES_DE_DATOS.Empleado
PRINT 'Migración de BI_Empleado terminada'
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
    ticket_total,
    t.ticket_total_descuento_aplicado,
	ticket_monto_total_envio
FROM REYES_DE_DATOS.Ticket t
    JOIN REYES_DE_DATOS.Ticket_X_Pago x on t.id_ticket = x.id_ticket
    JOIN REYES_DE_DATOS.Pago p on x.id_pago = p.id_pago;
PRINT 'Migración de BI_Venta terminada' --si tira error aca todavia no se que es, no tiene sentido porque no esta vinculada con producto
GO
------------------------------------------------------------ Item Ticket
INSERT INTO BI_REYES_DE_DATOS.BI_Ticket -- error no se porque
(
    ticket_numero,
    id_sucursal,
    id_tipo_comprobante,
    id_producto,
    item_ticket_cantidad,
    item_ticket_precio
)
SELECT
	t.ticket_numero,
    id_sucursal,
    id_tipo_comprobante,
    id_producto,
    item_ticket_cantidad,
    item_ticket_precio
FROM REYES_DE_DATOS.Item_Ticket t
PRINT 'Migración de BI_Ticket terminada'
GO --kk esto no se que error tiene
------------------------------------------------------------ Envio
INSERT INTO BI_REYES_DE_DATOS.BI_Envio ( --error no se porque
    id_ticket,
    id_cliente,
    envio_fecha_programada,
    envio_horario_inicio,
    envio_horario_fin,
    envio_fecha_entrega,
    envio_costo
)
SELECT
	e.id_ticket,
    e.id_cliente,
    e.envio_fecha_programada,
    e.envio_horario_inicio,
    e.envio_horario_fin,
    e.envio_fecha_entrega,
    e.envio_costo
FROM REYES_DE_DATOS.Envio e
PRINT 'Migración de BI_Envio terminada'
GO
------------------------------------------------------------ Promocion
INSERT INTO BI_REYES_DE_DATOS.BI_Promocion(
	id_promo,
	promo_descripcion
)
SELECT
	id_promo,
	promo_descripcion
FROM REYES_DE_DATOS.Promocion
PRINT 'Migración de BI_Promo terminada'
GO
----- ----- ----- ----- ----- 
----- CREACION DE HECHOS ----- 
----- ----- ----- ----- -----
------------------------------------------------------------ hechos venta tiempo
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
    l.localidad_nombre;
GO
----- 
-- 2) Vista para calcular la cantidad de unidades promedio por turno para cada cuatrimestre de cada año
----- 
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
	join BI_REYES_DE_DATOS.BI_Ticket t on t.id_ticket = v.id_ticket
GROUP BY
	BI_REYES_DE_DATOS.turno(v.ticket_fecha_hora),
	tmp.cuatrimestre,
	tmp.anio;
GO
----- 
-- 3) REVISAR Vista para calcular porcentaje anual de ventas registradas por rango etario del empleado según el tipo de caja para cada cuatrimestre.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre AS
SELECT
    BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento) as RangoEtario,
    c.caja_tipo as TipoCaja,
    t.cuatrimestre as Cuatrimestre,
    (
        SUM(v.venta_total) * 100
        /
        (
            SELECT SUM(v2.venta_total)
                FROM BI_REYES_DE_DATOS.BI_Venta v2
                    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt2 ON v2.id_ticket = vt2.id_venta
                    JOIN BI_REYES_DE_DATOS.BI_Tiempo t2 ON vt2.id_tiempo = t2.id_tiempo
                WHERE
                    t2.anio = t.anio
        )
    ) as Porcentaje
FROM 
    BI_REYES_DE_DATOS.BI_Venta v
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON v.id_ticket = vt.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON vt.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Caja c ON c.id_caja = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Empleado e ON v.venta_id_empleado = e.id_empleado
GROUP BY
    BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento),
    c.caja_tipo,
    t.cuatrimestre,
    t.anio;
GO
----- 
-- 4) Vista para calcular cantidad de ventas registradas por turno para cada localidad según el mes de cada año
-----
CREATE VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Ventas_Por_Turno_Y_Localidad AS
SELECT
    l.localidad_nombre as Localidad,
    t.mes as Mes,
    t.anio as Año,
    BI_REYES_DE_DATOS.turno(v.ticket_fecha_hora) as Turno,
    count(*) as CantidadVentas
FROM BI_REYES_DE_DATOS.BI_Venta v
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
	JOIN BI_REYES_DE_DATOS.BI_hechos_venta_ubicacion vu ON vu.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Sucursal s ON v.venta_id_sucursal = s.id_sucursal
    JOIN BI_REYES_DE_DATOS.BI_Ubicacion u ON vu.id_ubicacion = u.id_ubicacion
	join REYES_DE_DATOS.Localidad l on u.id_localidad = l.id_localidad
GROUP BY
    l.localidad_nombre,
    t.mes,
    t.anio,
    BI_REYES_DE_DATOS.turno(v.ticket_fecha_hora);
GO
----- 
-- 5) Vista para calcular el porcentaje de descuento aplicados en función del total de los tickets según el mes de cada año
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes AS
SELECT
	t.anio as Año,
	t.mes as Mes,
	(count(distinct v.ticket_total_descuento_aplicado) * 100) / (count (distinct v.id_venta)) as Porcentaje
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt on v.id_ticket = vt.id_venta
	join BI_REYES_DE_DATOS.BI_Tiempo t on vt.id_tiempo = t.id_tiempo
WHERE v.ticket_total_descuento_aplicado is not null
GROUP BY
	t.anio,
	t.mes;
GO
----- 
-- 6) Vista para calcular las tres categorías de productos con mayor descuento aplicado a partir de promociones para cada cuatrimestre de cada año.
-----
CREATE VIEW BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento AS
SELECT top 3
	t.anio as Anio,
    t.cuatrimestre as Cuatrimestre,
    pc.producto_categoria_detalle as Categoria,
    sum(v.ticket_total_descuento_aplicado) as DescuentoAplicado
FROM BI_REYES_DE_DATOS.BI_Venta v
	join BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt on v.id_ticket = vt.id_venta
	join BI_REYES_DE_DATOS.BI_Tiempo t on vt.id_tiempo = t.id_tiempo
	join BI_REYES_DE_DATOS.BI_Ticket tck on v.id_ticket = tck.id_ticket
	join REYES_DE_DATOS.Producto p on tck.id_producto = p.id_producto
	join BI_REYES_DE_DATOS.BI_Producto_categoria pc on p.id_producto_categoria = pc.id_producto_categoria
WHERE v.ticket_total_descuento_aplicado IS NOT NULL
GROUP BY
    t.anio,
	t.cuatrimestre,
	pc.producto_categoria_detalle;
GO
----- 
-- 7) Vista para calcular porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
-----
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios AS
SELECT
    s.id_sucursal AS Sucursal,
    t.anio AS Año,
    t.mes AS Mes,
    (
        COUNT(
            CASE 
                WHEN 
                    e.envio_fecha_entrega <= e.envio_fecha_programada
                THEN 1 
            ELSE NULL 
            END
        ) * 100.0
    ) / COUNT(e.id_envio) AS PorcentajeDeCumplimiento
FROM BI_REYES_DE_DATOS.BI_Envio e
    JOIN BI_REYES_DE_DATOS.BI_Venta v ON e.id_ticket = v.id_ticket 
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Sucursal s ON v.venta_id_sucursal = s.id_sucursal
where e.envio_fecha_entrega is not null
    and e.envio_fecha_programada is not null
GROUP BY
    s.id_sucursal,
    t.anio,
    t.mes;
GO
----- 
-- 8) Vista para calcular la cantidad de envíos por rango etario de clientes para cada cuatrimestre de cada año.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Cantidad_Envios_Rango_Etario AS
SELECT
    BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento) as RangoEtarioCliente,
    t.cuatrimestre as Cuatrimeste,
    t.anio as Año,
    count(*) as CantidadEnvios
FROM BI_REYES_DE_DATOS.BI_Envio e
    JOIN BI_REYES_DE_DATOS.BI_Venta v ON e.id_ticket = v.id_ticket
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo 
	JOIN BI_REYES_DE_DATOS.BI_Cliente c ON e.id_cliente = c.id_cliente
GROUP BY
    BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento),
    t.cuatrimestre,
    t.anio;
GO
----- 
-- 9) Vista para calcular las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.
----- 
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
	l.localidad_nombre;
GO
----- 
-- 10) Vista para calcular las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de pago, mes y año.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas AS
SELECT TOP 3
    s.id_sucursal as Sucursal,
    mp.medio_de_pago_clasificacion as MedioDePago,
    t.anio as Anio,
    t.mes as Mes,
    sum(p.pago_importe) as ImporteCuotas
FROM BI_REYES_DE_DATOS.BI_Venta v
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
	join BI_REYES_DE_DATOS.BI_Sucursal s on v.venta_id_sucursal = s.id_sucursal
	join BI_REYES_DE_DATOS.BI_Ticket tk on v.id_ticket = tk.id_ticket
	join REYES_DE_DATOS.Ticket_X_Pago x on x.id_ticket = v.id_ticket
    join REYES_DE_DATOS.Pago p on p.id_pago = x.id_pago
    join REYES_DE_DATOS.Tipo_medio_de_pago mp on p.id_tipo_medio_de_pago = mp.id_tipo_medio_pago
where p.medio_de_pago_cuotas is not null
GROUP BY
    s.id_sucursal,
    mp.medio_de_pago_clasificacion,
    t.anio,
    t.mes;
GO
----- 
-- 11) Vista para calcular el promedio de importe de la cuota en función del rango etareo del cliente.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Promedio_Importe_Cuota_RangoEtario AS
SELECT
    BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento) AS RangoEtario,
    AVG(p.pago_importe) AS PromedioImporteCuota
FROM BI_REYES_DE_DATOS.BI_Envio e
    JOIN BI_REYES_DE_DATOS.BI_Venta v ON e.id_ticket = v.id_ticket
	join BI_REYES_DE_DATOS.BI_Sucursal s on v.venta_id_sucursal = s.id_sucursal
	join BI_REYES_DE_DATOS.BI_Ticket tk on v.id_ticket = tk.id_ticket
	join REYES_DE_DATOS.Ticket_X_Pago x on x.id_ticket = v.id_ticket
    join REYES_DE_DATOS.Pago p on p.id_pago = x.id_pago
    JOIN BI_REYES_DE_DATOS.BI_Cliente c ON e.id_cliente = c.id_cliente
GROUP BY
    BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento);
GO
----- 
-- 12) Vista para calcular el porcentaje de descuento aplicado por cada medio de pago en función del valor de total de pagos sin el descuento, por cuatrimestre.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Medio_Pago AS
SELECT
    mp.medio_de_pago_clasificacion as MedioPago,
    t.anio as Año,
    t.cuatrimestre as Cuatrimestre,
    (count(distinct v.ticket_total_descuento_aplicado) * 100) / (count (distinct v.id_venta)) as Porcentaje
FROM BI_REYES_DE_DATOS.BI_Venta v
    JOIN BI_REYES_DE_DATOS.BI_hechos_venta_tiempo vt ON vt.id_venta = v.id_venta
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
	join BI_REYES_DE_DATOS.BI_Ticket tk on v.id_ticket = tk.id_ticket
	join REYES_DE_DATOS.Ticket_X_Pago x on x.id_ticket = v.id_ticket
    join REYES_DE_DATOS.Pago p on p.id_pago = x.id_pago
    join REYES_DE_DATOS.Tipo_medio_de_pago mp on p.id_tipo_medio_de_pago = mp.id_tipo_medio_pago
GROUP BY
    mp.medio_de_pago_clasificacion,
    t.anio,
    t.cuatrimestre;
GO
-------------------------------------------------------------------
----- BORRAR TODO ESQUEMA POR LAS DUDAS -----
-------------------------------------------------------------------
/*
DECLARE @schemaName NVARCHAR(255) = 'BI_REYES_DE_DATOS';
DECLARE @sql NVARCHAR(MAX) = '';

-- Generar comandos DROP para todas las restricciones de clave foránea
SELECT @sql = @sql + 'ALTER TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + ';' + CHAR(13)
FROM sys.foreign_keys fk
INNER JOIN sys.tables t ON fk.parent_object_id = t.object_id
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @schemaName;

-- Generar comandos DROP para todas las tablas
SELECT @sql = @sql + 'DROP TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ';' + CHAR(13)
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @schemaName;

-- Generar comandos DROP para todas las vistas
SELECT @sql = @sql + 'DROP VIEW ' + QUOTENAME(s.name) + '.' + QUOTENAME(v.name) + ';' + CHAR(13)
FROM sys.views v
INNER JOIN sys.schemas s ON v.schema_id = s.schema_id
WHERE s.name = @schemaName;

-- Generar comandos DROP para todas las funciones
SELECT @sql = @sql + 'DROP FUNCTION ' + QUOTENAME(s.name) + '.' + QUOTENAME(f.name) + ';' + CHAR(13)
FROM sys.objects f
INNER JOIN sys.schemas s ON f.schema_id = s.schema_id
WHERE s.name = @schemaName AND f.type IN ('FN', 'IF', 'TF');

-- Generar comandos DROP para todos los procedimientos almacenados
SELECT @sql = @sql + 'DROP PROCEDURE ' + QUOTENAME(s.name) + '.' + QUOTENAME(p.name) + ';' + CHAR(13)
FROM sys.procedures p
INNER JOIN sys.schemas s ON p.schema_id = s.schema_id
WHERE s.name = @schemaName;

-- Generar comandos DROP para el esquema
SET @sql = @sql + 'DROP SCHEMA ' + QUOTENAME(@schemaName) + ';' + CHAR(13);

-- Ejecutar los comandos generados
EXEC sp_executesql @sql;
*/

/*
venta ubicacion
*/
