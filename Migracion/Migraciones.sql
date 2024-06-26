USE GD1C2024
GO

------------------------------------------------------------------------------------------------
----- DROPEO DE TABLAS (respetar orden establecido) -----
------------------------------------------------------------------------------------------------

if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Regla_x_Promocion') begin DROP TABLE REYES_DE_DATOS.Regla_x_Promocion; end
if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Promocion_X_Producto') begin DROP TABLE REYES_DE_DATOS.Promocion_X_Producto; end
if exists(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Promocion_X_Item_Ticket')begin DROP TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Ticket_X_Pago') begin DROP TABLE REYES_DE_DATOS.Ticket_X_Pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Pago') begin DROP TABLE REYES_DE_DATOS.Pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Item_Ticket') begin DROP TABLE REYES_DE_DATOS.Item_Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Envio') begin DROP TABLE REYES_DE_DATOS.Envio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Ticket') begin DROP TABLE REYES_DE_DATOS.Ticket; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Producto') begin DROP TABLE REYES_DE_DATOS.Producto; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Empleado') begin DROP TABLE REYES_DE_DATOS.Empleado; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Cliente') begin DROP TABLE REYES_DE_DATOS.Cliente; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Sucursal') begin DROP TABLE REYES_DE_DATOS.Sucursal; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Domicilio') begin DROP TABLE REYES_DE_DATOS.Domicilio; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Caja') begin DROP TABLE REYES_DE_DATOS.Caja; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Promocion') begin DROP TABLE REYES_DE_DATOS.Promocion; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Localidad') begin DROP TABLE REYES_DE_DATOS.Localidad; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Provincia') begin DROP TABLE REYES_DE_DATOS.Provincia; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_Comprobante') begin DROP TABLE REYES_DE_DATOS.Tipo_Comprobante; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_Caja') begin DROP TABLE REYES_DE_DATOS.Tipo_Caja; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Supermercado') begin DROP TABLE REYES_DE_DATOS.Supermercado; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Regla') begin DROP TABLE REYES_DE_DATOS.Regla; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Descuento') begin DROP TABLE REYES_DE_DATOS.Descuento; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Tipo_medio_de_pago') begin DROP TABLE REYES_DE_DATOS.Tipo_medio_de_pago; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Producto_marca') begin DROP TABLE REYES_DE_DATOS.Producto_marca; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Producto_subcategoria')begin DROP TABLE REYES_DE_DATOS.Producto_subcategoria; end
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'REYES_DE_DATOS' AND TABLE_NAME = 'Producto_categoria') begin DROP TABLE REYES_DE_DATOS.Producto_categoria; end
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'REYES_DE_DATOS')
BEGIN EXEC ('CREATE SCHEMA REYES_DE_DATOS')
END
GO
------------------------------------------------------------------------------------------------
----- CREACIÓN DE TABLAS (respetar orden establecido) -----
------------------------------------------------------------------------------------------------

CREATE TABLE REYES_DE_DATOS.Producto_categoria (
	id_producto_categoria INT PRIMARY KEY IDENTITY(1,1),
	producto_categoria_detalle VARCHAR(50) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Producto_subcategoria (
	id_producto_subcategoria INT PRIMARY KEY IDENTITY(1,1),
	producto_subcategoria_detalle VARCHAR(50) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Producto_marca (
	id_producto_marca INT PRIMARY KEY IDENTITY(1,1),
	producto_marca_detalle VARCHAR(30) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Tipo_medio_de_pago (
	id_tipo_medio_pago INT PRIMARY KEY IDENTITY(1,1),
	medio_de_pago_clasificacion VARCHAR(100) NOT NULL, -- credito / debito / efectivo / etc
	medio_de_pago_detalle VARCHAR(100) NOT NULL, -- visa / mastercard / efectivo / etc
);
---
CREATE TABLE REYES_DE_DATOS.Descuento (
	descuento_codigo INT PRIMARY KEY NOT NULL,
	descuento_descripcion VARCHAR(100) NOT NULL,
	descuento_fecha_inicio DATE NOT NULL,
	descuento_fecha_fin DATE NOT NULL,
	descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
	descuento_tope DECIMAL(10, 2) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Regla(
	id_regla INT PRIMARY KEY IDENTITY(1,1),
	regla_cantidad_aplicable INT NOT NULL,
	regla_descripcion VARCHAR(50) UNIQUE NOT NULL,
	regla_cantidad_aplicable_descuento INT NOT NULL,
	regla_cantidad_maxima INT NOT NULL,
	regla_misma_marca BIT NOT NULL,
	regla_mismo_producto BIT NOT NULL,
	regla_descuento_aplicable_prod DECIMAL(3, 2) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Supermercado (
	id_supermercado INT PRIMARY KEY IDENTITY(1,1),
	super_nombre VARCHAR(50) UNIQUE NOT NULL,
	super_razon_social VARCHAR(100) NOT NULL,
	super_cuit VARCHAR(30) NOT NULL,
	super_iibb VARCHAR(30) NOT NULL, --Ingr. Brut. N°: 133452135
	super_fecha_inicio_actividad DATE NOT NULL,
	super_condicion_fiscal VARCHAR(50) NOT NULL
);
---
/*
CREATE TABLE REYES_DE_DATOS.Tipo_Caja(
	id_tipo_caja INT PRIMARY KEY IDENTITY(1,1),
	tipo_caja_descripcion VARCHAR(50) UNIQUE NOT NULL,
);
*/
---
CREATE TABLE REYES_DE_DATOS.Tipo_Comprobante(
	id_tipo_comprobante INT PRIMARY KEY IDENTITY(1,1),
	tipo_comprobante_nombre VARCHAR (1) NOT NULL, --caracter
);
---
CREATE TABLE REYES_DE_DATOS.Provincia(
	id_provincia INT PRIMARY KEY IDENTITY(1,1),
	provincia_nombre VARCHAR(50) UNIQUE NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Localidad(
	id_localidad INT PRIMARY KEY IDENTITY(1,1),
	localidad_nombre VARCHAR(50) UNIQUE NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Promocion(
	id_promo INT PRIMARY KEY NOT NULL,
	promo_descripcion VARCHAR(50) NOT NULL,
	promo_fecha_inicio DATETIME NOT NULL,
	promo_fecha_fin DATETIME NOT NULL,
);
------------------------------------------------------------------------------------------------
----- Tablas con Clave foranea -----
------------------------------------------------------------------------------------------------
---
CREATE TABLE REYES_DE_DATOS.Caja(
	id_caja INT PRIMARY KEY IDENTITY(1,1),
	caja_numero INT NOT NULL,
	caja_tipo VARCHAR(30) NOT NULL, 
);
---
CREATE TABLE REYES_DE_DATOS.Domicilio (
    id_domicilio INT PRIMARY KEY IDENTITY(1,1),
    id_localidad INT NOT NULL,
    id_provincia INT NOT NULL,
    domicilio_direccion VARCHAR(100) NOT NULL
);
---
CREATE TABLE REYES_DE_DATOS.Sucursal (
    id_sucursal INT PRIMARY KEY IDENTITY(1,1),
    sucursal_id_supermercado INT NOT NULL,
    sucursal_domicilio VARCHAR(100) NOT NULL,
    sucursal_numero VARCHAR(50) NOT NULL -- solo el numero
);

---
CREATE TABLE REYES_DE_DATOS.Cliente (
    id_cliente INT PRIMARY KEY IDENTITY(1,1),
    cliente_dni INT NOT NULL,
    cliente_id_domicilio INT NOT NULL,
    cliente_nombre VARCHAR(100) NOT NULL,
    cliente_apellido VARCHAR(100) NOT NULL,
    cliente_fecha_registro DATE NOT NULL,
    cliente_mail VARCHAR(100) NOT NULL,
    cliente_fecha_nacimiento DATE NOT NULL
);


---
CREATE TABLE REYES_DE_DATOS.Empleado (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE,
    empleado_fecha_nacimiento DATE,
    empleado_email VARCHAR(30) NOT NULL,
    empleado_telefono DECIMAL(8, 0) NOT NULL
);
---
CREATE TABLE REYES_DE_DATOS.Producto (
	id_producto INT PRIMARY KEY IDENTITY(1,1),
	producto_codigo NVARCHAR(100) NOT NULL, -- PRODUCTO_NOMBRE
    id_producto_categoria INT NOT NULL,
    id_producto_subcategoria INT NOT NULL,
    id_marca INT NOT NULL,
    producto_descripcion NVARCHAR(100) NOT NULL,
    producto_precio DECIMAL(10, 2) NOT NULL
);
---
CREATE TABLE REYES_DE_DATOS.Ticket(
    id_ticket INT PRIMARY KEY IDENTITY(1,1),
	ticket_numero INT NOT NULL, -- TICKET_NUMERO
    id_tipo_comprobante INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_caja INT NOT NULL,
    id_empleado INT NOT NULL,
    ticket_fecha_hora DATE NOT NULL,
    ticket_subtotal DECIMAL(10, 2) NOT NULL,
    ticket_total DECIMAL(10, 2) NOT NULL,
    ticket_total_descuento_aplicado INT NOT NULL,
	ticket_total_descuento_aplicado_mp INT NOT NULL,
    ticket_monto_total_envio INT NOT NULL
);
---
CREATE TABLE REYES_DE_DATOS.Envio (
    id_envio INT PRIMARY KEY IDENTITY(1,1),
    id_ticket INT NOT NULL,
    id_cliente INT NOT NULL,
    envio_fecha_programada DATETIME NULL,
    envio_horario_inicio INT NOT NULL,
    envio_horario_fin INT NOT NULL,
    envio_fecha_entrega DATETIME NOT NULL,
    envio_estado VARCHAR(50) NOT NULL,
    envio_costo DECIMAL(10, 2) NOT NULL,
);
---
CREATE TABLE REYES_DE_DATOS.Item_Ticket (
    id_item_ticket INT PRIMARY KEY IDENTITY(1,1),
    ticket_numero VARCHAR(50) NOT NULL,
    id_producto INT NOT NULL,
    id_tipo_comprobante INT NOT NULL,
    id_sucursal INT NOT NULL,
    id_promocion INT,
    item_ticket_cantidad INT NOT NULL,
    item_ticket_precio INT NOT NULL
);
--
CREATE TABLE REYES_DE_DATOS.Pago(
	id_pago INT PRIMARY KEY IDENTITY(1,1), 
	id_tipo_medio_de_pago INT NOT NULL,
	id_descuento INT NOT NULL,
	--id_cliente int not null,
	pago_fecha DATETIME NOT NULL,
	pago_importe DECIMAL(15,2) NOT NULL,
	pago_numero_tarjeta VARCHAR(20), -- SON OPCIONALES PORQUE PUEDE PAGAR EN EFECTIVO
	medio_de_pago_cuotas INT,
	medio_de_pago_fecha_vencimiento DATETIME,
	medio_de_pago_descuento_aplicado DECIMAL(10, 2),
);

------------------------------------------------------------------------------------------------
----- TABLAS COMPOSICION -----
------------------------------------------------------------------------------------------------
CREATE TABLE REYES_DE_DATOS.Regla_x_Promocion (
	id_promocion INT NOT NULL,
	id_regla INT NOT NULL,
);
--
CREATE TABLE REYES_DE_DATOS.Ticket_X_Pago(
	id_ticket INT NOT NULL,
	id_pago INT NOT NULL,
);
--
CREATE TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket (--
	id_promocion INT NOT NULL,
	id_item_ticket INT NOT NULL,
);
--
CREATE TABLE REYES_DE_DATOS.Promocion_X_Producto (
	id_promocion INT NOT NULL,
	id_producto INT NOT NULL,
);
GO
------------------------------------------------------------------------------------------------
----- CONSTRAINTS CLAVES PRIMARIAS Y FORANEAS -----
------------------------------------------------------------------------------------------------
--ALTER TABLE REYES_DE_DATOS.Promocion_X_Producto ADD CONSTRAINT PK_Promocion_X_Producto PRIMARY KEY (id_promocion)
ALTER TABLE REYES_DE_DATOS.Promocion_X_Producto ADD CONSTRAINT FK_Promoxion_X_Producto_id_promocion FOREIGN KEY (id_promocion) REFERENCES REYES_DE_DATOS.Promocion(id_promo)
ALTER TABLE REYES_DE_DATOS.Promocion_X_Producto ADD CONSTRAINT FK_Promoxion_X_Producto_id_producto FOREIGN KEY (id_producto) REFERENCES REYES_DE_DATOS.Producto(id_producto)

--ALTER TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket ADD CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_item_ticket);
ALTER TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket ADD CONSTRAINT FK_Promocion_X_ItemTicket_Promocion FOREIGN KEY (id_promocion) REFERENCES REYES_DE_DATOS.Promocion(id_promo)
ALTER TABLE REYES_DE_DATOS.Promocion_X_Item_Ticket ADD CONSTRAINT FK_Promocion_X_ItemTicket_Item_Ticket FOREIGN KEY (id_item_ticket) REFERENCES REYES_DE_DATOS.Item_Ticket(id_item_ticket)

--ALTER TABLE REYES_DE_DATOS.Ticket_X_Pago ADD CONSTRAINT PK_Ticket_X_Pago PRIMARY KEY (id_ticket, id_pago)
ALTER TABLE REYES_DE_DATOS.Ticket_X_Pago ADD CONSTRAINT FK_Ticket_X_Pago_id_ticket FOREIGN KEY (id_ticket) REFERENCES REYES_DE_DATOS.Ticket (id_ticket)
ALTER TABLE REYES_DE_DATOS.Ticket_X_Pago ADD CONSTRAINT FK_Ticket_X_Pago_id_pago FOREIGN KEY (id_pago) REFERENCES REYES_DE_DATOS.Pago (id_pago)

--ALTER TABLE REYES_DE_DATOS.Regla_x_Promocion ADD CONSTRAINT PK_Regla_X_Promocion PRIMARY KEY (id_promocion, id_regla)
ALTER TABLE REYES_DE_DATOS.Regla_x_Promocion ADD CONSTRAINT FK_Regla_X_Promocion_Promocion FOREIGN KEY (id_promocion) REFERENCES REYES_DE_DATOS.Promocion(id_promo)
ALTER TABLE REYES_DE_DATOS.Regla_x_Promocion ADD CONSTRAINT FK_Regla_X_Promocion_Regla FOREIGN KEY (id_regla) REFERENCES REYES_DE_DATOS.Regla(id_regla)

ALTER TABLE REYES_DE_DATOS.Pago ADD CONSTRAINT FK_id_descuento FOREIGN KEY (id_descuento) REFERENCES REYES_DE_DATOS.Descuento(descuento_codigo)
--ALTER TABLE REYES_DE_DATOS.Pago ADD CONSTRAINT FK_id_cliente FOREIGN KEY (id_cliente) REFERENCES REYES_DE_DATOS.Cliente(id_cliente)
--ALTER TABLE REYES_DE_DATOS.Pago ADD CONSTRAINT FK_id_tipo_medio_pago FOREIGN KEY (id_tipo_medio_pago) REFERENCES REYES_DE_DATOS.Tipo_medio_de_pago(id_tipo_medio_pago)

ALTER TABLE REYES_DE_DATOS.Item_Ticket ADD CONSTRAINT FK_id_producto FOREIGN KEY (id_producto) REFERENCES REYES_DE_DATOS.Producto(id_producto)
ALTER TABLE REYES_DE_DATOS.Item_Ticket ADD CONSTRAINT FK_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES REYES_DE_DATOS.Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE REYES_DE_DATOS.Item_Ticket ADD CONSTRAINT FK_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES REYES_DE_DATOS.Sucursal(id_sucursal)
ALTER TABLE REYES_DE_DATOS.Item_Ticket ADD CONSTRAINT FK_id_promocion FOREIGN KEY (id_promocion) REFERENCES REYES_DE_DATOS.Promocion(id_promo)

--ALTER TABLE REYES_DE_DATOS.Envio ADD CONSTRAINT FK_id_ticket FOREIGN KEY (id_ticket) REFERENCES REYES_DE_DATOS.Ticket(id_ticket)
ALTER TABLE REYES_DE_DATOS.Envio ADD CONSTRAINT FK_id_cliente_envio FOREIGN KEY (id_cliente) REFERENCES REYES_DE_DATOS.Cliente(id_cliente)

ALTER TABLE REYES_DE_DATOS.Ticket ADD CONSTRAINT FK_id_tipo_comprobante_ticket FOREIGN KEY (id_tipo_comprobante) REFERENCES REYES_DE_DATOS.Tipo_Comprobante(id_tipo_comprobante)
ALTER TABLE REYES_DE_DATOS.Ticket ADD CONSTRAINT FK_id_sucursal_ticket FOREIGN KEY (id_sucursal) REFERENCES REYES_DE_DATOS.Sucursal(id_sucursal)
ALTER TABLE REYES_DE_DATOS.Ticket ADD CONSTRAINT FK_id_caja_ticket FOREIGN KEY (id_caja) REFERENCES REYES_DE_DATOS.Caja(id_caja)
ALTER TABLE REYES_DE_DATOS.Ticket ADD CONSTRAINT FK_id_empleado_ticket FOREIGN KEY (id_empleado) REFERENCES REYES_DE_DATOS.Empleado(id_empleado)

ALTER TABLE REYES_DE_DATOS.Producto ADD CONSTRAINT FK_id_producto_categoria FOREIGN KEY (id_producto_categoria) REFERENCES REYES_DE_DATOS.Producto_categoria(id_producto_categoria)
ALTER TABLE REYES_DE_DATOS.Producto ADD CONSTRAINT FK_id_producto_subcategoria FOREIGN KEY (id_producto_subcategoria) REFERENCES REYES_DE_DATOS.Producto_subcategoria(id_producto_subcategoria)
ALTER TABLE REYES_DE_DATOS.Producto ADD CONSTRAINT FK_id_marca FOREIGN KEY (id_marca) REFERENCES REYES_DE_DATOS.Producto_marca(id_producto_marca)

ALTER TABLE REYES_DE_DATOS.Empleado ADD CONSTRAINT FK_id_sucursal_empleado FOREIGN KEY (id_sucursal) REFERENCES REYES_DE_DATOS.Sucursal(id_sucursal)
ALTER TABLE REYES_DE_DATOS.Empleado ADD CONSTRAINT UQ_empleado_email_empleado UNIQUE (empleado_email)
ALTER TABLE REYES_DE_DATOS.Empleado ADD CONSTRAINT UQ_empleado_telefono_empleado UNIQUE (empleado_telefono)

ALTER TABLE REYES_DE_DATOS.Cliente ADD CONSTRAINT FK_cliente_id_domicilio FOREIGN KEY (cliente_id_domicilio) REFERENCES REYES_DE_DATOS.Domicilio(id_domicilio)

ALTER TABLE REYES_DE_DATOS.Domicilio ADD CONSTRAINT FK_id_localidad FOREIGN KEY (id_localidad) REFERENCES REYES_DE_DATOS.Localidad(id_localidad)
ALTER TABLE REYES_DE_DATOS.Domicilio ADD CONSTRAINT FK_id_provincia FOREIGN KEY (id_provincia) REFERENCES REYES_DE_DATOS.Provincia(id_provincia)

GO
------------------------------------------------------------------------------------------------
----- MIGRACION (respetar orden establecido) -----
------------------------------------------------------------------------------------------------
INSERT INTO REYES_DE_DATOS.Producto_categoria(producto_categoria_detalle)
	SELECT DISTINCT PRODUCTO_CATEGORIA
	FROM gd_esquema.Maestra
	WHERE PRODUCTO_CATEGORIA IS NOT NULL	
PRINT 'Migración de categoria terminada';

INSERT INTO REYES_DE_DATOS.Producto_subcategoria(producto_subcategoria_detalle)
	SELECT DISTINCT m.PRODUCTO_SUB_CATEGORIA
	FROM gd_esquema.Maestra m
	WHERE m.PRODUCTO_SUB_CATEGORIA IS NOT NULL		
PRINT 'Migración de subcategoria terminada';

INSERT INTO REYES_DE_DATOS.Producto_marca(producto_marca_detalle)
	SELECT DISTINCT m.PRODUCTO_MARCA
	FROM gd_esquema.Maestra m
	WHERE m.PRODUCTO_MARCA IS NOT NULL
PRINT 'Migración de marca terminada';

INSERT INTO REYES_DE_DATOS.Tipo_medio_de_pago(medio_de_pago_clasificacion, medio_de_pago_detalle)
	SELECT DISTINCT m.PAGO_TIPO_MEDIO_PAGO, m.PAGO_MEDIO_PAGO
	FROM gd_esquema.Maestra m
	WHERE m.PAGO_TIPO_MEDIO_PAGO IS NOT NULL
		AND m.PAGO_MEDIO_PAGO IS NOT NULL
PRINT 'Migración de medio de pago terminada';

INSERT INTO REYES_DE_DATOS.Descuento(
	descuento_codigo,
	descuento_descripcion,
	descuento_fecha_inicio,
	descuento_fecha_fin,
	descuento_valor_porcentual_a_aplicar,
	descuento_tope
	)
SELECT DISTINCT m.DESCUENTO_CODIGO,
	m.DESCUENTO_DESCRIPCION,
	m.DESCUENTO_FECHA_INICIO,
	m.DESCUENTO_FECHA_FIN,
	m.DESCUENTO_PORCENTAJE_DESC,
	m.DESCUENTO_TOPE
FROM gd_esquema.Maestra m
WHERE m.DESCUENTO_CODIGO IS NOT NULL
PRINT 'Migración de descuento terminada';

INSERT INTO REYES_DE_DATOS.Regla(
	regla_descripcion,
	regla_cantidad_aplicable,
	regla_cantidad_aplicable_descuento,
	regla_cantidad_maxima,
	regla_misma_marca,
	regla_mismo_producto,
	regla_descuento_aplicable_prod
)
SELECT DISTINCT       
	m.REGLA_DESCRIPCION,
	m.REGLA_CANT_APLICABLE_REGLA,
	m.REGLA_CANT_APLICA_DESCUENTO,
	m.REGLA_CANT_MAX_PROD,
	m.REGLA_APLICA_MISMA_MARCA,
	m.REGLA_APLICA_MISMO_PROD,
	m.REGLA_DESCUENTO_APLICABLE_PROD
FROM gd_esquema.Maestra m
WHERE m.REGLA_DESCRIPCION IS NOT NULL
PRINT 'Migración de regla terminada';

INSERT INTO REYES_DE_DATOS.Supermercado(
	super_nombre,
	super_razon_social,
	super_cuit,
	super_iibb, 
	super_fecha_inicio_actividad,
	super_condicion_fiscal
)
SELECT DISTINCT m.SUPER_NOMBRE,
	m.SUPER_RAZON_SOC,
	m.SUPER_CUIT,
	m.SUPER_IIBB,
	m.SUPER_FECHA_INI_ACTIVIDAD,
	m.SUPER_CONDICION_FISCAL
FROM gd_esquema.Maestra m
WHERE m.SUPER_CUIT IS NOT NULL
PRINT 'Migración de supermercado terminada';
/*
INSERT INTO REYES_DE_DATOS.Tipo_Caja(tipo_caja_descripcion)
	SELECT DISTINCT CAJA_TIPO
	FROM gd_esquema.Maestra
	WHERE CAJA_TIPO IS NOT NULL
PRINT 'Migración de tipo de caja terminada';
*/
INSERT INTO REYES_DE_DATOS.Tipo_Comprobante(tipo_comprobante_nombre)
	SELECT DISTINCT TICKET_TIPO_COMPROBANTE
	FROM gd_esquema.Maestra
	WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
PRINT 'Migración de tipo de comprobante terminada';

INSERT INTO REYES_DE_DATOS.Provincia(provincia_nombre)
	SELECT DISTINCT CLIENTE_PROVINCIA
	FROM gd_esquema.Maestra 
	WHERE CLIENTE_PROVINCIA IS NOT NULL
	UNION SELECT SUCURSAL_PROVINCIA AS provincia
		FROM gd_esquema.Maestra
		WHERE SUCURSAL_PROVINCIA IS NOT NULL
	UNION SELECT SUPER_PROVINCIA AS provincia
		FROM gd_esquema.Maestra
		WHERE SUPER_PROVINCIA IS NOT NULL;
PRINT 'Migración de Provincia terminada';

INSERT INTO REYES_DE_DATOS.Localidad(localidad_nombre)
	SELECT DISTINCT CLIENTE_LOCALIDAD
	FROM gd_esquema.Maestra 
	WHERE CLIENTE_LOCALIDAD IS NOT NULL
	UNION SELECT SUCURSAL_LOCALIDAD
		FROM gd_esquema.Maestra
		WHERE SUCURSAL_LOCALIDAD IS NOT NULL
	UNION SELECT SUPER_LOCALIDAD
		FROM gd_esquema.Maestra
		WHERE SUPER_LOCALIDAD IS NOT NULL;
PRINT 'Migración de Localidad terminada';

INSERT INTO REYES_DE_DATOS.Promocion(
		id_promo,
		promo_descripcion,
		promo_fecha_inicio,
		promo_fecha_fin	
	)
	SELECT DISTINCT
		PROMO_CODIGO,
		PROMOCION_DESCRIPCION,
		PROMOCION_FECHA_INICIO,
		PROMOCION_FECHA_FIN
	FROM gd_esquema.Maestra
	WHERE PROMO_CODIGO IS NOT NULL
PRINT 'Migración de promocion terminada';

INSERT INTO REYES_DE_DATOS.Caja(
	caja_numero,
	caja_tipo
	)
	SELECT DISTINCT
	m.CAJA_NUMERO, 
	m.CAJA_TIPO
	FROM gd_esquema.Maestra m
	WHERE CAJA_NUMERO IS NOT NULL
PRINT 'Migración de caja terminada';

INSERT INTO REYES_DE_DATOS.Domicilio (
	domicilio_direccion,
	id_localidad,
	id_provincia
	) 
	SELECT DISTINCT
		m.SUPER_DOMICILIO,
		l.id_localidad,
		p.id_provincia
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Localidad l ON l.localidad_nombre = m.SUPER_LOCALIDAD
		JOIN REYES_DE_DATOS.Provincia p ON p.provincia_nombre = m.SUPER_PROVINCIA
	WHERE SUPER_DOMICILIO IS NOT NULL;
PRINT 'Migracion de Domicilio de supermercado terminada';

INSERT INTO REYES_DE_DATOS.Domicilio (
	domicilio_direccion,
	id_localidad,
	id_provincia
)
SELECT DISTINCT
	m.CLIENTE_DOMICILIO,
	l.id_localidad,
	p.id_provincia
FROM gd_esquema.Maestra m
	JOIN REYES_DE_DATOS.Localidad l ON l.localidad_nombre = m.CLIENTE_LOCALIDAD
	JOIN REYES_DE_DATOS.Provincia p ON p.provincia_nombre = m.CLIENTE_PROVINCIA
WHERE CLIENTE_DOMICILIO IS NOT NULL;

INSERT INTO REYES_DE_DATOS.Domicilio (
	domicilio_direccion,
	id_localidad,
	id_provincia
)
SELECT DISTINCT
	m.SUCURSAL_DIRECCION,
	l.id_localidad,
	p.id_provincia
FROM gd_esquema.Maestra m
	JOIN REYES_DE_DATOS.Localidad l ON l.localidad_nombre = m.CLIENTE_LOCALIDAD
	JOIN REYES_DE_DATOS.Provincia p ON p.provincia_nombre = m.CLIENTE_PROVINCIA
WHERE SUCURSAL_DIRECCION IS NOT NULL;
PRINT 'Migracion de Domicilio de cliente terminada';

INSERT INTO REYES_DE_DATOS.Sucursal (
	sucursal_domicilio,
	sucursal_id_supermercado,
	sucursal_numero -- solo el numero
)
SELECT DISTINCT
	m.SUCURSAL_DIRECCION,
	s.id_supermercado,
	m.SUCURSAL_NOMBRE	
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Supermercado s ON m.SUPER_NOMBRE = s.super_nombre
PRINT 'Migración de sucursal terminada';

INSERT INTO REYES_DE_DATOS.Cliente(
	cliente_dni,
	cliente_id_domicilio,
	cliente_nombre,
	cliente_apellido,
	cliente_fecha_registro,
	cliente_mail,
	cliente_fecha_nacimiento
	)
	SELECT DISTINCT
		m.CLIENTE_DNI,
		d.id_domicilio,
		m.CLIENTE_NOMBRE,
		m.CLIENTE_APELLIDO,
		m.CLIENTE_FECHA_REGISTRO,
		m.CLIENTE_MAIL,
		m.CLIENTE_FECHA_NACIMIENTO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Domicilio d ON m.CLIENTE_DOMICILIO = d.domicilio_direccion
	WHERE m.CLIENTE_DNI IS NOT NULL
PRINT 'Migración de cliente terminada';

INSERT INTO REYES_DE_DATOS.Empleado(
	id_sucursal,
	empleado_nombre,
	empleado_apellido,
	empleado_dni,
	empleado_fecha_registro,
	empleado_fecha_nacimiento,
	empleado_email,
	empleado_telefono
	)
	SELECT DISTINCT
		s.id_sucursal,
		m.EMPLEADO_NOMBRE,
		m.EMPLEADO_APELLIDO,
		m.EMPLEADO_DNI,
		m.EMPLEADO_FECHA_REGISTRO,
		m.EMPLEADO_FECHA_NACIMIENTO,
		m.EMPLEADO_MAIL,
		m.EMPLEADO_TELEFONO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Sucursal s ON m.SUCURSAL_NOMBRE = s.sucursal_numero
	WHERE m.EMPLEADO_DNI IS NOT NULL
PRINT 'Migración de empleado terminada';

INSERT INTO REYES_DE_DATOS.Producto(
	producto_codigo, -- PRODUCTO_NOMBRE
	id_producto_categoria,
	id_producto_subcategoria,
	id_marca,
	producto_descripcion,
	producto_precio
	)
	SELECT DISTINCT
		m.PRODUCTO_NOMBRE,
		c.id_producto_categoria,
		sc.id_producto_subcategoria,
		mc.id_producto_marca,
		m.PRODUCTO_DESCRIPCION,
		m.PRODUCTO_PRECIO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Producto_categoria c ON m.PRODUCTO_CATEGORIA = c.producto_categoria_detalle
		JOIN REYES_DE_DATOS.Producto_subcategoria sc ON m.PRODUCTO_SUB_CATEGORIA = sc.producto_subcategoria_detalle
		JOIN REYES_DE_DATOS.Producto_marca mc ON m.PRODUCTO_MARCA = mc.producto_marca_detalle
	WHERE m.PRODUCTO_NOMBRE IS NOT NULL
PRINT 'Migración de producto terminada';

INSERT INTO REYES_DE_DATOS.Ticket(
	ticket_numero,
	id_tipo_comprobante,
	id_sucursal,
	id_caja,
	id_empleado,
	ticket_fecha_hora,
	ticket_subtotal,
	ticket_total,
	ticket_total_descuento_aplicado,
	ticket_total_descuento_aplicado_mp,
	ticket_monto_total_envio
	)
	SELECT DISTINCT
		m.TICKET_NUMERO,
		tc.id_tipo_comprobante,
		sc.id_sucursal,
		c.id_caja,
		e.id_empleado,
		m.TICKET_FECHA_HORA,
		m.TICKET_SUBTOTAL_PRODUCTOS,
		m.TICKET_TOTAL_TICKET,
		m.TICKET_TOTAL_DESCUENTO_APLICADO,
		m.TICKET_TOTAL_DESCUENTO_APLICADO_MP,
		m.TICKET_TOTAL_ENVIO
	FROM gd_esquema.Maestra m 
		JOIN REYES_DE_DATOS.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
		JOIN REYES_DE_DATOS.Empleado e ON m.EMPLEADO_DNI = e.empleado_dni
		JOIN REYES_DE_DATOS.Sucursal sc ON m.SUCURSAL_NOMBRE = sc.sucursal_numero
		JOIN REYES_DE_DATOS.Caja c ON m.CAJA_NUMERO = c.caja_numero AND m.CAJA_TIPO = c.caja_tipo 
	WHERE m.TICKET_NUMERO IS NOT NULL
	ORDER BY m.TICKET_NUMERO
PRINT 'Migración de Ticket terminada';

INSERT INTO REYES_DE_DATOS.Envio(
	id_ticket,
	id_cliente,
	envio_fecha_programada,
	envio_horario_inicio,
	envio_horario_fin,
	envio_fecha_entrega,
	envio_estado,
	envio_costo
	)
	SELECT 
		t.id_ticket,
		c.id_cliente,
		m.ENVIO_FECHA_PROGRAMADA,
		m.ENVIO_HORA_INICIO,
		m.ENVIO_HORA_FIN,
		m.ENVIO_FECHA_ENTREGA,
		m.ENVIO_ESTADO,
		m.ENVIO_COSTO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Cliente c ON m.CLIENTE_MAIL = c.cliente_mail
		join REYES_DE_DATOS.Ticket t on m.TICKET_NUMERO+m.TICKET_SUBTOTAL_PRODUCTOS+m.TICKET_TOTAL_TICKET = t.ticket_numero+t.ticket_subtotal+t.ticket_total
	WHERE m.TICKET_NUMERO IS NOT NULL
		AND m.ENVIO_HORA_INICIO IS NOT NULL    
PRINT 'Migración de envio terminada';

INSERT INTO REYES_DE_DATOS.Item_Ticket(
	ticket_numero,
	id_producto,
	id_tipo_comprobante,
	id_sucursal,
	id_promocion,
	item_ticket_cantidad,
	item_ticket_precio
	)
	SELECT DISTINCT
		m.TICKET_NUMERO,
		p.id_producto,
		tc.id_tipo_comprobante,
		s.id_sucursal,
		m.PROMO_CODIGO,
		m.TICKET_DET_CANTIDAD,
		m.TICKET_DET_PRECIO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Sucursal s ON m.SUCURSAL_DIRECCION = s.sucursal_domicilio
		JOIN REYES_DE_DATOS.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
		JOIN REYES_DE_DATOS.Producto p ON m.PRODUCTO_PRECIO = p.producto_precio AND m.PRODUCTO_NOMBRE = p.producto_codigo
	WHERE m.TICKET_NUMERO IS NOT NULL
		AND m.PRODUCTO_NOMBRE IS NOT NULL
		AND m.TICKET_DET_CANTIDAD IS NOT NULL
		AND m.TICKET_DET_PRECIO IS NOT NULL
PRINT 'Migración de item ticket terminada';

INSERT INTO REYES_DE_DATOS.Pago(
	id_tipo_medio_de_pago,
	id_descuento,
	pago_fecha,
	pago_importe,
	pago_numero_tarjeta,
	medio_de_pago_cuotas,
	medio_de_pago_fecha_vencimiento,
	medio_de_pago_descuento_aplicado
	)
	SELECT
		mp.id_tipo_medio_pago,
		m.DESCUENTO_CODIGO,
		m.PAGO_FECHA,
		m.PAGO_IMPORTE,
		m.PAGO_TARJETA_NRO,
		m.PAGO_TARJETA_CUOTAS,
		m.PAGO_TARJETA_FECHA_VENC,
		m.PAGO_DESCUENTO_APLICADO
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Tipo_medio_de_pago mp ON m.PAGO_MEDIO_PAGO = mp.medio_de_pago_detalle
PRINT 'Migración de Pago terminada'; 

INSERT INTO REYES_DE_DATOS.Regla_x_Promocion(
	id_promocion,
	id_regla
	)
	SELECT DISTINCT
		m.PROMO_CODIGO,
		r.id_regla
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Regla r ON m.REGLA_DESCRIPCION = r.regla_descripcion 
	WHERE m.PROMO_CODIGO IS NOT NULL AND 2 IS NOT NULL
PRINT 'Migración de regla x promocion terminada';

INSERT INTO REYES_DE_DATOS.Ticket_X_Pago(
	id_ticket,
	id_pago
	)
	SELECT DISTINCT
		t.id_ticket,
		p.id_pago
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Ticket t ON m.TICKET_NUMERO = t.ticket_numero
		JOIN REYES_DE_DATOS.Pago p ON t.ticket_total = p.pago_importe AND t.ticket_fecha_hora = p.pago_fecha
	WHERE t.id_ticket IS NOT NULL
		and p.id_pago IS NOT NULL
PRINT 'Migración de ticket_x_pago terminada';

--esta tiene que tardar mucho porque a cada item le pertenece una promocion (esto nos come 30s de ejecucion como minimo)
INSERT INTO REYES_DE_DATOS.Promocion_X_Item_Ticket(
	id_promocion,
	id_item_ticket
	)
	SELECT DISTINCT
		p.id_promo,
		it.id_item_ticket
	FROM gd_esquema.Maestra m 
		JOIN REYES_DE_DATOS.Promocion p ON 
			m.PROMOCION_DESCRIPCION = p.promo_descripcion 
			AND m.PROMOCION_FECHA_INICIO = p.promo_fecha_inicio 
			AND m.PROMOCION_FECHA_FIN = p.promo_fecha_fin
		JOIN REYES_DE_DATOS.Producto pr ON 
			m.PRODUCTO_PRECIO = pr.producto_precio 
			AND m.PRODUCTO_NOMBRE = pr.producto_codigo
		JOIN REYES_DE_DATOS.Item_Ticket it ON
			m.TICKET_NUMERO = it.ticket_numero
			AND pr.id_producto = it.id_producto
			AND m.PROMO_CODIGO = it.id_promocion
	WHERE 
		m.TICKET_NUMERO IS NOT NULL
		AND m.PROMO_CODIGO IS NOT NULL 
PRINT 'Migración de promo_x_item_ticket terminada';

INSERT INTO REYES_DE_DATOS.Promocion_X_Producto(
	id_promocion,
	id_producto
	)
	SELECT DISTINCT
			m.PROMO_CODIGO,
			p.id_promo
	FROM gd_esquema.Maestra m
		JOIN REYES_DE_DATOS.Promocion p ON 
			m.PROMOCION_DESCRIPCION = p.promo_descripcion 
			AND m.PROMOCION_FECHA_INICIO = p.promo_fecha_inicio 
			AND m.PROMOCION_FECHA_FIN = p.promo_fecha_fin
	WHERE 
		m.TICKET_NUMERO IS NOT NULL
		AND m.PROMO_CODIGO IS NOT NULL
PRINT 'Migración de promocion_x_producto terminada';
GO

/*
kk
Promocion_X_Item_Ticket
*/
------------------------------------------------------------------------------------------------
----- COMPROBACION PARA ROLLBACK -----
------------------------------------------------------------------------------------------------

IF (
	EXISTS (SELECT 1 FROM REYES_DE_DATOS.Producto_categoria) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Producto_subcategoria)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Producto_marca)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Tipo_medio_de_pago)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Descuento) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Regla) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Tipo_Comprobante) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Provincia) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Localidad) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Promocion) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Caja) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Domicilio) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Sucursal) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Cliente) 
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Empleado)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Producto)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Ticket)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Envio)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Item_Ticket)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Pago)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Regla_x_Promocion)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Ticket_X_Pago)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Promocion_X_Item_Ticket)
	AND EXISTS (SELECT 1 FROM REYES_DE_DATOS.Promocion_X_Producto)
)
	BEGIN
		PRINT 'Las tablas fueron migradas correctamente.'	
	END
ELSE
	BEGIN
		RAISERROR ('Error al migrar una o más tablas', 14, 1)
	END
GO

/*
Cosas finales Para revisar
pago
reglaXpromocion
ticketXpago
promocionXproducto
*/
