/*SI SALTA ERROR DE FOREIGN KEY CORRER DOS VECES EL CODIGO*/

/*
No identifica correctamente los hechos. Los hechos son: Ventas / Promociones / Pagos / Envios.
Las tablas de hechos deben tener información agrupada y sumarizada por sus dimensiones y no contener información del modelo relacional en particular. Si la tabla del modelo relacional y la tabla de hechos tienen la misma cantidad de registros está mal. 
En el hecho de ventas no pueden tener información del modelo relación de los tickets específicos.
La dimensión Producto no es correcta, no pueden identificar un producto en particular.
La dimensión promoción no es correcta porque debería ser un hecho
No pueden tener la dimensión empleado y cliente, por algo se les pide la dimensión Rango Etario.
*/

USE [GD1C2024]
GO
----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- 
----- CORRER ESTO INDIVIDUALMENTE ANTES DE CADA TEST COMPLETO ----- 
----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- 
------------------------------------------------------------ Tablas 
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Tiempo') begin DROP TABLE BI_REYES_DE_DATOS.BI_Tiempo; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Ubicacion') begin DROP TABLE BI_REYES_DE_DATOS.BI_Ubicacion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Sucursal') begin DROP TABLE BI_REYES_DE_DATOS.BI_Sucursal; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_medio_de_pago') begin DROP TABLE BI_REYES_DE_DATOS.BI_medio_de_pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Producto_categoria') begin DROP TABLE BI_REYES_DE_DATOS.BI_Producto_categoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_Producto_subcategoria') begin DROP TABLE BI_REYES_DE_DATOS.BI_Producto_subcategoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_venta') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_venta; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_envio') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_envio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_pago') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'BI_REYES_DE_DATOS' AND TABLE_NAME = 'BI_hechos_promociones') begin DROP TABLE BI_REYES_DE_DATOS.BI_hechos_promociones; end
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
------------------------------------------------------------ esquema
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'BI_REYES_DE_DATOS')
BEGIN EXEC ('CREATE SCHEMA BI_REYES_DE_DATOS') END
GO
----- ----- ----- ----- ----- ----
-----  CREACIÓN DE FUNCIONES -----
----- ----- ----- ----- ----- ----- 
------------------------------------------------------------ Turno
CREATE FUNCTION BI_REYES_DE_DATOS.turno(@hora TIME)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @turno VARCHAR(50);
    SELECT @turno = 
        CASE 
            WHEN @hora BETWEEN '08:00:00' AND '11:59:59' THEN 'Turno de 8 a 12'
            WHEN @hora BETWEEN '12:00:00' AND '15:59:59' THEN 'Turno de 12 a 16'
            WHEN @hora BETWEEN '16:00:00' AND '20:00:00' THEN 'Turno de 16 a 20'
            ELSE 'Fuera de turno'
        END;
    RETURN @turno;
END;
GO
------------------------------------------------------------ Rango Etario
CREATE FUNCTION BI_REYES_DE_DATOS.rangoEtario(@fechaNacimiento AS DATE)
RETURNS VARCHAR(30)
AS
BEGIN
	DECLARE @edad INT
	SET @edad = YEAR(GETDATE()) - YEAR(@fechaNacimiento) 
	DECLARE @rangoEtario VARCHAR(30)
	
	IF(@edad < 25)
		SET @rangoEtario = 'Menor a 25'
	IF(@edad BETWEEN 25 AND 34)
		SET @rangoEtario = '25 a 35'
	IF(@edad BETWEEN 35 AND 50)
		SET @rangoEtario = '35 a 50'
	IF(@edad > 50)
		SET @rangoEtario = 'Mas de 50'

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
----- ----- ----- ----- ----- ----- ----- ----- 
----- CREACIÓN DE TABLAS-DIMENSIONES ----- 
----- ----- ----- ----- ----- ----- ----- -----
------
CREATE TABLE BI_REYES_DE_DATOS.BI_Tiempo(
	id_tiempo INT PRIMARY KEY IDENTITY(1,1),
	anio INT NOT NULL, 
	cuatrimestre INT NOT NULL,
	mes INT NOT NULL
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_Ubicacion( -- == Domicilio
	id_ubicacion INT PRIMARY KEY,
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
----- ----- ----- ----- ----- ----- ----- 
----- CREACIÓN DE TABLAS-HECHOS ----- 
----- ----- ----- ----- ----- ----- -----
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_envio (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
  	id_tiempo int not null,
	id_ubicacion int not null,
	id_sucursal int not null,
	id_turno varchar(50) not null,
	id_rango_etario varchar(30) not null,
    envio_fecha_programada DATETIME NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_venta(
  	id_venta INT PRIMARY KEY IDENTITY(1,1),
  	id_tiempo INT NOT NULL,
	id_ubicacion INT NOT NULL,
	id_sucursal INT NOT NULL,
	id_turno varchar(50) NOT NULL,
	id_rango_etario varchar(30) NOT NULL,
	id_categoria_prod INT NOT NULL,
	id_subcategoria INT NOT NULL,
	id_medio_de_pago INT NOT NULL,
    venta_id_caja INT NOT NULL,
    monto_ventas DECIMAL(10, 2) NOT NULL,
	cantidad_ventas int not null,
    monto_descuentos_aplicados DECIMAL(10, 2),
	cantidad_descuentos int not null
);
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_pago (
  	id_pago INT PRIMARY KEY IDENTITY(1,1),
  	id_tiempo INT NOT NULL,
	--id_ubicacion INT NOT NULL,
	id_sucursal INT NOT NULL,
	id_turno varchar(50) NOT NULL,
	--id_rango_etario varchar(30) NOT NULL,
	id_medio_de_pago INT NOT NULL,
  	monto_pagos INT NOT NULL,
	cantidad_pagos INT NOT NULL,
); 
-----
CREATE TABLE BI_REYES_DE_DATOS.BI_hechos_promociones (
  	id_promocion INT NOT NULL,
	id_categoria_prod INT NOT NULL,
	id_subcategoria INT NOT NULL,
	cantidad_promociones INT NOT NULL,
);
------------------------------------------------------------------------------------------------
----- CONSTRAINTS CLAVES PRIMARIAS Y FORANEAS -----
------------------------------------------------------------------------------------------------
ALTER TABLE BI_REYES_DE_DATOS.BI_hechos_venta ADD CONSTRAINT FK_id_sucursal_hechos_venta FOREIGN KEY (id_sucursal) REFERENCES BI_REYES_DE_DATOS.BI_Sucursal(id_sucursal)
GO
----- ----- ----- ----- ----- ----- ----- ----- 
-----  CREACIÓN DE MIGRACIONES-DIMENSIONES -----
----- ----- ----- ----- ----- ----- ----- ----- 
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
	id_ubicacion,
	id_provincia,
	id_localidad,
	direccion
)
SELECT
	d.id_domicilio,
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
----- ----- ----- ----- ----- ----- ----- ----- 
-----  CREACIÓN DE MIGRACIONES-HECHOS -----
----- ----- ----- ----- ----- ----- ----- -----
------------------------------------------------------------ Envio
INSERT INTO BI_REYES_DE_DATOS.BI_hechos_envio (
  	id_tiempo,
	id_ubicacion,
	id_sucursal,
	id_rango_etario,
	id_turno,
    envio_fecha_programada,
    envio_fecha_entrega,
    envio_costo
)
SELECT
	t.id_tiempo,
	u.id_ubicacion,
	--s.id_sucursal,
	BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento),
	BI_REYES_DE_DATOS.turno(CAST(e.envio_fecha_entrega AS TIME)),
	e.envio_fecha_programada,
	e.envio_fecha_entrega,
	sum(e.envio_costo)
FROM REYES_DE_DATOS.Envio e
	join BI_REYES_DE_DATOS.BI_Tiempo t on 
		year(e.envio_fecha_entrega) = t.anio
		and month(e.envio_fecha_entrega) = t.mes
		and BI_REYES_DE_DATOS.cuatrimestre(month(e.envio_fecha_entrega)) = t.cuatrimestre
	join REYES_DE_DATOS.Cliente c on c.id_cliente = e.id_cliente
	join BI_REYES_DE_DATOS.BI_Ubicacion u on c.cliente_id_domicilio = u.id_ubicacion
	--join BI_REYES_DE_DATOS.BI_Sucursal s on s.sucursal_domicilio = u.direccion
group by t.id_tiempo,
	u.id_ubicacion,
	--s.id_sucursal,
	BI_REYES_DE_DATOS.rangoEtario(c.cliente_fecha_nacimiento),
	BI_REYES_DE_DATOS.turno(CAST(e.envio_fecha_entrega AS TIME)),
	e.envio_fecha_programada,
	e.envio_fecha_entrega
PRINT 'Migración de BI_hechos_envio terminada'
GO
------------------------------------------------------------ Venta
INSERT INTO BI_REYES_DE_DATOS.BI_hechos_venta(
	id_tiempo,
	id_ubicacion,
	id_sucursal,
	id_turno,
	id_rango_etario,
	id_categoria_prod,
	id_subcategoria,
	id_medio_de_pago,
    venta_id_caja,
    monto_ventas,
	cantidad_ventas,
    monto_descuentos_aplicados,
	cantidad_descuentos
)
SELECT
	tp.id_tiempo,
	u.id_ubicacion,
	s.id_sucursal,
	BI_REYES_DE_DATOS.turno(CAST(t.ticket_fecha_hora AS TIME)),
	BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento),
	p.id_producto_categoria,
	p.id_producto_subcategoria,
	mp.id_tipo_medio_pago,
	t.id_caja,
	sum(t.ticket_total),
	count(t.ticket_total),
	sum(t.ticket_total_descuento_aplicado),
	count(t.ticket_total_descuento_aplicado)
FROM REYES_DE_DATOS.Ticket t
	JOIN BI_REYES_DE_DATOS.BI_Tiempo tp on
		year(t.ticket_fecha_hora) = tp.anio
		and month(t.ticket_fecha_hora) = tp.mes
		and BI_REYES_DE_DATOS.cuatrimestre(month(t.ticket_fecha_hora)) = tp.cuatrimestre
	JOIN BI_REYES_DE_DATOS.BI_Sucursal s on s.id_sucursal = t.id_sucursal
	JOIN BI_REYES_DE_DATOS.BI_Ubicacion u on u.direccion = s.sucursal_domicilio
	JOIN REYES_DE_DATOS.Empleado e on t.id_empleado = e.id_empleado
	JOIN REYES_DE_DATOS.Item_Ticket i on i.ticket_numero+i.id_sucursal+i.id_tipo_comprobante = t.ticket_numero+t.id_sucursal+t.id_tipo_comprobante
	JOIN REYES_DE_DATOS.Producto p on i.id_producto = p.id_producto
	JOIN REYES_DE_DATOS.Ticket_X_Pago x on t.id_ticket = x.id_ticket
	JOIN REYES_DE_DATOS.Pago pg on x.id_pago = pg.id_pago
	JOIN REYES_DE_DATOS.Tipo_medio_de_pago mp on pg.id_tipo_medio_de_pago = mp.id_tipo_medio_pago
GROUP BY tp.id_tiempo,
	tp.id_tiempo,
	u.id_ubicacion,
	s.id_sucursal,
	BI_REYES_DE_DATOS.turno(CAST(t.ticket_fecha_hora AS TIME)),
	BI_REYES_DE_DATOS.rangoEtario(e.empleado_fecha_nacimiento),
	p.id_producto_categoria,
	p.id_producto_subcategoria,
	mp.id_tipo_medio_pago,
	t.id_caja
PRINT 'Migración de BI_hechos_venta terminada'
GO
------------------------------------------------------------ Pago
INSERT INTO BI_REYES_DE_DATOS.BI_hechos_pago(
	id_tiempo,
	id_sucursal,
	id_turno,
	id_medio_de_pago,
  	monto_pagos,
	cantidad_pagos
	--id_ubicacion,
	--id_rango_etario
)
SELECT
	t.id_tiempo,
	tk.id_sucursal,
	BI_REYES_DE_DATOS.turno(CAST(p.pago_fecha AS TIME)),
	p.id_tipo_medio_de_pago,
	sum(p.pago_importe),
	count(p.pago_importe)
FROM REYES_DE_DATOS.Pago p
	JOIN BI_REYES_DE_DATOS.BI_Tiempo t on
		year(p.pago_fecha) = t.anio
		and month(p.pago_fecha) = t.mes
		and BI_REYES_DE_DATOS.cuatrimestre(month(p.pago_fecha)) = t.cuatrimestre
	JOIN REYES_DE_DATOS.Ticket_X_Pago x on p.id_pago = x.id_pago
	JOIN REYES_DE_DATOS.Ticket tk on x.id_ticket = tk.id_ticket
WHERE p.pago_fecha is not null
GROUP BY 
	t.id_tiempo,
	tk.id_sucursal,
	BI_REYES_DE_DATOS.turno(CAST(p.pago_fecha AS TIME)),
	p.id_tipo_medio_de_pago
PRINT 'Migración de BI_Pago terminada'
GO
------------------------------------------------------------ Promocion
INSERT INTO BI_REYES_DE_DATOS.BI_hechos_promociones(
  	id_promocion,
	id_categoria_prod,
	id_subcategoria,
	cantidad_promociones
)
SELECT DISTINCT
	p.id_promo,
	pr.id_producto_categoria,
	pr.id_producto_subcategoria,
	count(*)
FROM REYES_DE_DATOS.Promocion p
	join REYES_DE_DATOS.Item_Ticket it on it.id_promocion = p.id_promo
	join REYES_DE_DATOS.Producto pr on pr.id_producto = it.id_producto
GROUP BY
	p.id_promo,
	pr.id_producto_categoria,
	pr.id_producto_subcategoria
PRINT 'Migración de BI_Promo terminada'
GO
----- ----- ----- ----- ----- ----- ----- 
----- CREACION DE MIGRACIONES EXTRAS ----- 
----- ----- ----- ----- ----- ----- -----

----- ----- ----- ----- ----- 
----- CREACION DE VIEWS ----- 
----- ----- ----- ----- -----
-----
-----
-- 1) Vista para calcular el ticket promedio mensual por localidad, año y mes
-----
CREATE VIEW BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual AS
SELECT
    AVG(v.monto_ventas) AS PromedioMensual,
    l.localidad_nombre,
    t.anio AS Año,
    t.mes AS Mes
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
	JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON v.id_tiempo = t.id_tiempo
	JOIN BI_REYES_DE_DATOS.BI_Ubicacion u ON v.id_ubicacion = u.id_ubicacion
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
	avg(v.cantidad_ventas) as Promedio,
	v.id_turno as Turno,
    t.cuatrimestre as Cuatrimestre,
    t.anio as Año
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
	JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON v.id_tiempo = t.id_tiempo
GROUP BY
	v.id_turno,
    t.cuatrimestre,
    t.anio;
GO
----- 
-- 3) Vista para calcular porcentaje anual de ventas registradas por rango etario del empleado según el tipo de caja para cada cuatrimestre.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre AS
SELECT
    v.id_rango_etario as RangoEtario,
    c.caja_tipo as TipoCaja,
    t.cuatrimestre as Cuatrimestre,
    (
        SUM(v.monto_ventas) * 100
        /
        (
            SELECT SUM(v2.monto_ventas)
                FROM BI_REYES_DE_DATOS.BI_hechos_venta v2
                    JOIN BI_REYES_DE_DATOS.BI_Tiempo t2 ON v2.id_tiempo = t2.id_tiempo
                WHERE t2.anio = t.anio
        )
    ) as Porcentaje
FROM 
    BI_REYES_DE_DATOS.BI_hechos_venta v
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON v.id_tiempo = t.id_tiempo
    JOIN REYES_DE_DATOS.Caja c ON c.id_caja = v.venta_id_caja
GROUP BY
	v.id_rango_etario,
    c.caja_tipo,
    t.cuatrimestre,
	t.anio;
GO
----- revisar
-- 4) Vista para calcular cantidad de ventas registradas por turno para cada localidad según el mes de cada año
-----
CREATE VIEW BI_REYES_DE_DATOS.Vista_Cantidad_Ventas_Por_Turno_Y_Localidad AS
SELECT
	v.id_turno as Turno,
    l.localidad_nombre as Localidad,
    t.mes as Mes,
    t.anio as Año,
    sum(v.cantidad_ventas) as CantidadVentas
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Sucursal s ON v.id_sucursal= s.id_sucursal
    JOIN BI_REYES_DE_DATOS.BI_Ubicacion u ON v.id_ubicacion = u.id_ubicacion
	join REYES_DE_DATOS.Localidad l on u.id_localidad = l.id_localidad
GROUP BY
	v.id_turno,
    l.localidad_nombre,
    t.mes,
    t.anio;
GO
----- revisar
-- 5) Vista para calcular el porcentaje de descuento aplicados en función del total de los tickets según el mes de cada año
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes AS
SELECT
	(sum(v.cantidad_descuentos) * 100) / (sum(v.cantidad_ventas)) as Porcentaje,
	t.mes as Mes,
	t.anio as Año
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
	join BI_REYES_DE_DATOS.BI_Tiempo t on v.id_tiempo = t.id_tiempo
GROUP BY
	t.anio,
	t.mes;
GO
----- 
-- 6) Vista para calcular las tres categorías de productos con mayor descuento aplicado a partir de promociones para cada cuatrimestre de cada año.
-----
CREATE VIEW BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento AS
SELECT top 3
    pc.producto_categoria_detalle as Categoria,
	sum(v.monto_descuentos_aplicados) as SumatoriaDescuentosAplicados,
	t.anio as Anio,
    t.cuatrimestre as Cuatrimestre
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
	join BI_REYES_DE_DATOS.BI_Tiempo t on v.id_tiempo = t.id_tiempo
	join BI_REYES_DE_DATOS.BI_Producto_categoria pc on v.id_categoria_prod = pc.id_producto_categoria
GROUP BY
    t.anio,
	t.cuatrimestre,
	pc.producto_categoria_detalle;
GO
----- revisar
-- 7) Vista para calcular porcentaje de cumplimiento de envíos en los tiempos programados por sucursal por año/mes (desvío)
-----
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios AS
SELECT
    s.id_sucursal AS Sucursal,
	(COUNT(CASE WHEN e.envio_fecha_entrega <= e.envio_fecha_programada THEN 1 ELSE NULL END) * 100.0) / COUNT(e.id_envio) AS PorcentajeDeCumplimiento,
    t.anio AS Año,
    t.mes AS Mes
FROM BI_REYES_DE_DATOS.BI_hechos_envio e
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON e.id_tiempo = t.id_tiempo
    JOIN BI_REYES_DE_DATOS.BI_Sucursal s ON e.id_sucursal = s.id_sucursal
where e.envio_fecha_entrega is not null and e.envio_fecha_programada is not null
GROUP BY
    s.id_sucursal,
    t.anio,
    t.mes;
GO
----- revisar 
-- 8) Vista para calcular la cantidad de envíos por rango etario de clientes para cada cuatrimestre de cada año.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Cantidad_Envios_Rango_Etario AS
SELECT
    count(*) as CantidadEnvios,
	e.id_rango_etario as RangoEtarioCliente,
    t.cuatrimestre as Cuatrimeste,
    t.anio as Año
FROM BI_REYES_DE_DATOS.BI_hechos_envio e
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON e.id_tiempo = t.id_tiempo 
GROUP BY
    e.id_rango_etario,
	t.cuatrimestre,
    t.anio;
GO
----- revisar
-- 9) Vista para calcular las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio AS
SELECT TOP 5
    l.localidad_nombre as Localidad,
    sum(e.envio_costo) as CostoEnvio
FROM BI_REYES_DE_DATOS.BI_hechos_envio e
	JOIN BI_REYES_DE_DATOS.BI_Ubicacion u on e.id_ubicacion = u.id_ubicacion
	JOIN REYES_DE_DATOS.Localidad l on u.id_localidad = l.id_localidad
	INNER JOIN REYES_DE_DATOS.Cliente c on u.id_ubicacion = c.cliente_id_domicilio
GROUP BY
    l.localidad_nombre;
GO
----- revisar
-- 10) Vista para calcular las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de pago, mes y año.
-----
CREATE VIEW BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas AS
SELECT top 3
    p.id_sucursal as Sucursal,
    sum(p.monto_pagos) as MayorImporteCuotas,
    mp.medio_de_pago_detalle as MedioDePago,
	t.mes as Mes,
    t.anio as Anio
FROM BI_REYES_DE_DATOS.BI_hechos_pago p
	JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON p.id_tiempo = t.id_tiempo	
    join BI_REYES_DE_DATOS.BI_medio_de_pago mp on p.id_medio_de_pago = mp.id_medio_de_pago
where mp.medio_de_pago_detalle != 'Efectivo'
GROUP BY
    p.id_sucursal,
    mp.medio_de_pago_detalle,
	t.anio,
	t.mes;
GO
----- 
-- 11) Vista para calcular el promedio de importe de la cuota en función del rango etareo del cliente.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Promedio_Importe_Cuota_RangoEtario AS
SELECT
    v.id_rango_etario AS RangoEtario,
    AVG(v.monto_ventas) AS PromedioImporteCuota
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
GROUP BY
   v.id_rango_etario;
GO
----- revisar
-- 12) Vista para calcular el porcentaje de descuento aplicado por cada medio de pago en función del valor de total de pagos sin el descuento, por cuatrimestre.
----- 
CREATE VIEW BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Medio_Pago AS
SELECT
    mp.medio_de_pago_detalle as MedioPago,
    t.anio as Año,
    t.cuatrimestre as Cuatrimestre,
    (sum(v.cantidad_descuentos) * 100) / sum(v.cantidad_ventas) as Porcentaje
FROM BI_REYES_DE_DATOS.BI_hechos_venta v
    JOIN BI_REYES_DE_DATOS.BI_Tiempo t ON t.id_tiempo = t.id_tiempo
	JOIN BI_REYES_DE_DATOS.BI_medio_de_pago mp on v.id_medio_de_pago = mp.id_medio_de_pago
GROUP BY
    mp.medio_de_pago_detalle,
    t.anio,
    t.cuatrimestre;
GO
-------------------------------------------------------------------

-------------------------------------------------------------------
----- EJECUCION DE LAS VISTAS -----
-------------------------------------------------------------------
--1
select * from BI_REYES_DE_DATOS.BI_Vista_Ticket_Promedio_Mensual
--2
select * from BI_REYES_DE_DATOS.Vista_Cantidad_Unidades_Promedio
--3
select * from BI_REYES_DE_DATOS.BI_Porcentaje_Ventas_Por_Cuatrimestre
--4
select * from BI_REYES_DE_DATOS.Vista_Cantidad_Ventas_Por_Turno_Y_Localidad
--5
select * from BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Por_Mes
--6
select * from BI_REYES_DE_DATOS.Vista_Categorias_Productos_Con_Mayor_Descuento 
--7
select * from BI_REYES_DE_DATOS.BI_Porcentaje_Cumplimiento_Envios
--8
select * from BI_REYES_DE_DATOS.BI_Cantidad_Envios_Rango_Etario
--9
select * from BI_REYES_DE_DATOS.BI_Top_5_Localidades_Costo_Envio
--10
select * from BI_REYES_DE_DATOS.BI_Top3_Sucursales_Pagos_Cuotas
--11
select * from BI_REYES_DE_DATOS.BI_Promedio_Importe_Cuota_RangoEtario
--12
select * from BI_REYES_DE_DATOS.BI_Porcentaje_Descuento_Medio_Pago
