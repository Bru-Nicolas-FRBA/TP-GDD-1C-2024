USE [GD1C2024]
GO

CREATE SCHEMA [FRBA_SUPERMERCADO]
GO

----- CREACIÓN DE TABLAS (respetar orden establecido) -----
---
CREATE TABLE FRBA_SUPERMERCADO.Producto_categoria (id_producto_categoria INT PRIMARY KEY);
---
CREATE TABLE FRBA_SUPERMERCADO.Producto_subcategoria (id_producto_subcategoria INT PRIMARY KEY);
---
CREATE TABLE FRBA_SUPERMERCADO.Producto_marca (id_producto_marca INT PRIMARY KEY);
---
CREATE TABLE FRBA_SUPERMERCADO.Tipo_medio_de_pago (
	id_tipo_medio_pago INT PRIMARY KEY IDENTITY(1,1),
	medio_de_pago_clasificacion VARCHAR(100) UNIQUE NOT NULL, -- credito / debito / efectivo / etc
	medio_de_pago_detalle VARCHAR(100) UNIQUE NOT NULL, -- visa / mastercard / efectivo / etc
);
---
CREATE TABLE FRBA_SUPERMERCADO.Descuento (
	descuento_codigo INT PRIMARY KEY NOT NULL,
	descuento_descripcion VARCHAR(100) NOT NULL,
	descuento_fecha_inicio DATE NOT NULL,
	descuento_fecha_fin DATE NOT NULL,
	descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
	descuento_tope DECIMAL(10, 2) NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Regla(
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
CREATE TABLE FRBA_SUPERMERCADO.Supermercado (
	id_supermercado INT PRIMARY KEY IDENTITY(1,1),
	super_nombre VARCHAR(50) UNIQUE NOT NULL,
	super_razon_social VARCHAR(100) NOT NULL,
	super_cuit VARCHAR(30) NOT NULL,
	super_iibb VARCHAR(30) NOT NULL, --Ingr. Brut. N°: 133452135
	super_fecha_inicio_actividad DATE NOT NULL,
	super_condicion_fiscal VARCHAR(50) NOT NULL
);
---
CREATE TABLE FRBA_SUPERMERCADO.Tipo_Caja(
	id_tipo_caja INT PRIMARY KEY IDENTITY(1,1),
	tipo_caja_descripcion VARCHAR(50) UNIQUE NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Tipo_Comprobante(
	id_tipo_comprobante INT PRIMARY KEY IDENTITY(1,1),
	tipo_comprobante_nombre VARCHAR (1), --caracter
);
---
CREATE TABLE FRBA_SUPERMERCADO.Provincia(
	id_provincia INT PRIMARY KEY IDENTITY(1,1),
	provincia_nombre VARCHAR(50) UNIQUE NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Localidad(
	id_localidad INT PRIMARY KEY IDENTITY(1,1),
	localidad_nombre VARCHAR(50) UNIQUE NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Promocion(
	id_promo INT PRIMARY KEY IDENTITY(1,1),
	promo_codigo INT NOT NULL, -- codigo de uso (se repite)
	promo_descripcion VARCHAR(50) UNIQUE NOT NULL,
	promo_fecha_inicio DATE NOT NULL,
	promo_fecha_fin DATE NOT NULL,
	promo_valor_descuento DECIMAL(6,2) NOT NULL, 
);
----- Tablas con Clave foranea
---
CREATE TABLE FRBA_SUPERMERCADO.Caja(
	id_caja INT PRIMARY KEY IDENTITY(1,1),
	caja_numero INT, 	
	id_tipo_caja INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Tipo_Caja (id_tipo_caja)
);
---
CREATE TABLE FRBA_SUPERMERCADO.Domicilio (
	id_domicilio INT PRIMARY KEY IDENTITY(1,1),
	id_localidad INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Localidad(id_localidad) NOT NULL,
	id_provincia INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Provincia(id_provincia) NOT NULL,
	domicilio_direccion VARCHAR(100) NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Sucursal (
	id_sucursal INT PRIMARY KEY IDENTITY(1,1),
	id_domicilio INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Domicilio(id_domicilio) NOT NULL,
	id_supermercado INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Supermercado(id_supermercado) NOT NULL,
	sucursal_numero INT NOT NULL, -- solo el numero
);
---
CREATE TABLE FRBA_SUPERMERCADO.Cliente(
	id_cliente INT PRIMARY KEY IDENTITY(1,1),
	cliente_dni INT NOT NULL,
	cliente_id_domicilio INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Domicilio(id_domicilio) NOT NULL,
	--cliente_id_contacto INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Cliente_Contacto(id_cliente_contacto) NOT NULL,		
	cliente_nombre VARCHAR(100) NOT NULL,
	cliente_apellido VARCHAR(100) NOT NULL,
	cliente_fecha_registro DATE NOT NULL,
	cliente_mail VARCHAR(100) UNIQUE NOT NULL,
	cliente_fecha_nacimiento DATE NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Empleado(
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal) NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE NOT NULL,
    empleado_fecha_nacimiento DATE NOT NULL,
    empleado_email VARCHAR (30) UNIQUE NOT NULL,
	empleado_telefono DECIMAL(8,0) UNIQUE NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Producto (
	id_producto INT PRIMARY KEY, -- PRODUCTO_NOMBRE
	id_producto_categoria INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_categoria(id_producto_categoria) NOT NULL,
	id_producto_subcategoria INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_subcategoria(id_producto_subcategoria) NOT NULL,
	id_marca INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_marca(id_producto_marca) NOT NULL,
	producto_descripcion VARCHAR(100) NOT NULL,
	producto_precio DECIMAL(10,2) NOT NULL,
);
---
CREATE TABLE FRBA_SUPERMERCADO.Ticket( 
	id_ticket INT PRIMARY KEY NOT NULL, -- TICKET_NUMERO
	id_tipo_comprobante INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Tipo_Comprobante (id_tipo_comprobante) NOT NULL,
	id_sucursal INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal) NOT NULL,
	id_caja INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Caja (id_caja) NOT NULL,
	id_empleado INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Empleado (id_empleado) NOT NULL,
	ticket_fecha_hora DATE NOT NULL,
	ticket_subtotal DECIMAL(10, 2) NOT NULL,
	ticket_total DECIMAL(10, 2) NOT NULL,
	ticket_monto_total_promociones_aplicadas INT NOT NULL,
	ticket_monto_total_descuentos_aplicados INT NOT NULL,	
);
--
CREATE TABLE FRBA_SUPERMERCADO.Envio(
	id_envio INT PRIMARY KEY IDENTITY(1,1),
	id_ticket INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Ticket (id_ticket) NOT NULL,
	id_cliente INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Cliente (id_cliente) NOT NULL,
	envio_fecha_programada DATE NOT NULL,
	envio_horario_inicio TIME NOT NULL,
	envio_horario_fin TIME NOT NULL,
	envio_fecha_entrega DATE NOT NULL,
	envio_estado VARCHAR(50) NOT NULL,
	envio_costo DECIMAL(10, 2) NOT NULL,
	envio_estado_envio VARCHAR(50) NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Item_Ticket(
	id_item_ticket INT PRIMARY KEY IDENTITY(1,1),
	id_ticket INT FOREIGN KEY (id_ticket) REFERENCES FRBA_SUPERMERCADO.Ticket (id_ticket) NOT NULL,
	id_producto INT FOREIGN KEY (id_producto) REFERENCES FRBA_SUPERMERCADO.Producto (id_producto) NOT NULL,
	id_tipo_comprobante INT FOREIGN KEY (id_tipo_comprobante) REFERENCES FRBA_SUPERMERCADO.Tipo_Comprobante (id_tipo_comprobante) NOT NULL,
	id_sucursal INT FOREIGN KEY (id_sucursal)  REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal) NOT NULL,
	id_promocion INT FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion (id_promo) NOT NULL,
	item_ticket_cantidad INT NOT NULL,
	item_ticket_precio INT NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Pago(
	id_pago INT PRIMARY KEY IDENTITY(1,1),
	id_tipo_medio_de_pago INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Tipo_medio_de_pago(id_tipo_medio_pago) NOT NULL,
	id_cliente INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Cliente(id_cliente) NOT NULL,
	id_descuento INT FOREIGN KEY (id_descuento) REFERENCES FRBA_SUPERMERCADO.Descuento(descuento_codigo),
	pago_fecha DATE NOT NULL,
	pago_importe DECIMAL(10,2) NOT NULL,
	pago_numero_tarjeta VARCHAR(20), -- SON OPCIONALES PORQUE PUEDE PAGAR EN EFECTIVO
	medio_de_pago_cuotas INT,
	medio_de_pago_fecha_vencimiento DATE,
	medio_de_pago_descuento_aplicado DECIMAL(10, 2),
);
----- TABLAS COMPOSICION
CREATE TABLE FRBA_SUPERMERCADO.Regla_x_Promocion (
	id_promocion INT,
	id_regla INT,
	CONSTRAINT PK_Regla_X_Promocion PRIMARY KEY (id_promocion, id_regla),
	CONSTRAINT FK_Regla_X_Promocion_Promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promo),
	CONSTRAINT FK_Regla_X_Promocion_Regla FOREIGN KEY (id_regla) REFERENCES FRBA_SUPERMERCADO.Regla(id_regla)
);
--
CREATE TABLE FRBA_SUPERMERCADO.Ticket_X_Pago(
	id_ticket INT,
	id_pago INT,
	CONSTRAINT PK_Ticket_X_Pago PRIMARY KEY (id_ticket, id_pago),
	CONSTRAINT FK_Ticket_X_Pago_id_ticket FOREIGN KEY (id_ticket) REFERENCES FRBA_SUPERMERCADO.Ticket (id_ticket),
	CONSTRAINT FK_Ticket_X_Pago_id_pago FOREIGN KEY (id_pago) REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal)
);
--
CREATE TABLE FRBA_SUPERMERCADO.Promocion_X_Item_Ticket (--
	id_promocion INT,
	id_item_ticket INT,
	CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_item_ticket),
	CONSTRAINT FK_Promocion_X_ItemTicket_Promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promo),
	CONSTRAINT FK_Promocion_X_ItemTicket_Item_Ticket FOREIGN KEY (id_item_ticket) REFERENCES FRBA_SUPERMERCADO.Item_Ticket(id_item_ticket)
);
--
CREATE TABLE FRBA_SUPERMERCADO.Promocion_X_Producto (
	id_promocion INT,
	id_producto INT,
	CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_producto),
	CONSTRAINT FK_Promoxion_X_Producto_id_promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promo),
	CONSTRAINT FK_Promoxion_X_Producto_id_producto FOREIGN KEY (id_producto) REFERENCES FRBA_SUPERMERCADO.Producto(id_producto)
);
--
GO
----- FUNCIONES PARA USAR -----
--queda por definirse si es mas optimo llamar a las funciones o simplemente hacer los JOIN
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_provincia_id(@provincia_nombre VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @id_provincia INT;

    SELECT @id_provincia = id_provincia
    FROM FRBA_SUPERMERCADO.Provincia
    WHERE provincia_nombre = @provincia_nombre;

    RETURN @id_provincia;
END;
GO
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_localidad_id(@localidad_nombre VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @id_localidad INT;

    SELECT @id_localidad = id_localidad
    FROM FRBA_SUPERMERCADO.Localidad
    WHERE localidad_nombre = @localidad_nombre;

    RETURN @id_localidad;
END;
GO
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_domicilio_id(@domicilio VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @id_domicilio INT;

    SELECT @id_domicilio = domicilio_direccion
    FROM FRBA_SUPERMERCADO.Domicilio
    WHERE domicilio_direccion = @domicilio;
    RETURN @id_domicilio;
END;
GO
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_sucursal_id(@domicilio VARCHAR(50))
RETURNS INT
AS
BEGIN
	DECLARE @id_domicilio INT;
	
    SELECT @id_domicilio = s.id_domicilio
    FROM FRBA_SUPERMERCADO.Sucursal s
    WHERE s.id_domicilio = FRBA_SUPERMERCADO.get_domicilio_id(@domicilio);
    
    RETURN @id_domicilio;
END;
GO
----- PROCEDIMIENTOS DE MIGRACION -----
/*
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_
AS
BEGIN
	INSERT INTO
	SELECT
	FROM
	WHERE
	PRINT 'Migración de terminada';
END
GO
*/
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_categoria
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Producto_categoria(id_producto_categoria)
		SELECT DISTINCT CAST(SUBSTRING(m.PRODUCTO_CATEGORIA, 13,20) AS INT)
		FROM gd_esquema.Maestra m
		WHERE SUBSTRING(m.PRODUCTO_CATEGORIA, 13,20) IS NOT NULL	
	PRINT 'Migración de categoria terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_subcategoria
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Producto_subcategoria(id_producto_subcategoria)
		SELECT DISTINCT CAST(SUBSTRING(m.PRODUCTO_SUB_CATEGORIA, 13,20) AS INT)
		FROM gd_esquema.Maestra m
		WHERE SUBSTRING(m.PRODUCTO_SUB_CATEGORIA, 13,7) IS NOT NULL		
	PRINT 'Migración de subcategoria terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_marca
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Producto_marca(id_producto_marca)
		SELECT DISTINCT CAST(SUBSTRING(m.PRODUCTO_MARCA, 9,10) AS DECIMAL(10,0))
		FROM gd_esquema.Maestra m
		WHERE m.PRODUCTO_MARCA IS NOT NULL
	PRINT 'Migración de marca terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_tipo_medio_pago
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Tipo_medio_de_pago(medio_de_pago_clasificacion, medio_de_pago_detalle)
	SELECT DISTINCT m.PAGO_TIPO_MEDIO_PAGO, m.PAGO_MEDIO_PAGO
	FROM gd_esquema.Maestra m
	WHERE m.PAGO_TIPO_MEDIO_PAGO IS NOT NULL
		AND m.PAGO_MEDIO_PAGO IS NOT NULL
	PRINT 'Migración de medio de pago terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_descuento
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Descuento(
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
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_regla
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Regla(
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
	PRINT 'Migración de terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_supermercado
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Supermercado(
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
		(CAST(SUBSTRING(m.SUPER_IIBB, 16,10) AS DECIMAL(9,0))),
		m.SUPER_FECHA_INI_ACTIVIDAD,
		m.SUPER_CONDICION_FISCAL
	FROM gd_esquema.Maestra m
	WHERE m.SUPER_IIBB IS NOT NULL
	PRINT 'Migración de supermercado terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_tipo_caja
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Tipo_Caja(tipo_caja_descripcion)
        SELECT DISTINCT(SUBSTRING(CAJA_TIPO,11,20))
        FROM gd_esquema.Maestra
        WHERE CAJA_TIPO IS NOT NULL
	PRINT 'Migración de tipo de caja terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_tipo_comprobante
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Tipo_Comprobante(tipo_comprobante_nombre)
        SELECT DISTINCT TICKET_TIPO_COMPROBANTE
        FROM gd_esquema.Maestra
        WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
	PRINT 'Migración de tipo de comprobante terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_Provincia
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Provincia(provincia_nombre)
	SELECT CLIENTE_PROVINCIA
		FROM gd_esquema.Maestra 
		WHERE CLIENTE_PROVINCIA IS NOT NULL
		UNION SELECT SUCURSAL_PROVINCIA AS provincia
			FROM gd_esquema.Maestra
			WHERE SUCURSAL_PROVINCIA IS NOT NULL
		UNION SELECT SUPER_PROVINCIA AS provincia
			FROM gd_esquema.Maestra
			WHERE SUPER_PROVINCIA IS NOT NULL;
	PRINT 'Migración de Provincia terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_localidad
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Localidad(localidad_nombre)
	SELECT CLIENTE_LOCALIDAD
			FROM gd_esquema.Maestra 
			WHERE CLIENTE_LOCALIDAD IS NOT NULL
		UNION SELECT SUCURSAL_LOCALIDAD
			FROM gd_esquema.Maestra
			WHERE SUCURSAL_LOCALIDAD IS NOT NULL
		UNION SELECT SUPER_LOCALIDAD
			FROM gd_esquema.Maestra
			WHERE SUPER_LOCALIDAD IS NOT NULL;
	PRINT 'Migración de Localidad terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_promocion
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Promocion(
		promo_codigo, -- codigo de uso (se repite)
		promo_descripcion,
		promo_fecha_inicio,
		promo_fecha_fin,
		promo_valor_descuento
      )
      SELECT
        PROMO_CODIGO,
        PROMOCION_DESCRIPCION,
        PROMOCION_FECHA_INICIO,
        PROMOCION_FECHA_FIN,
        PROMO_APLICADA_DESCUENTO
      FROM gd_esquema.Maestra
        WHERE PROMO_CODIGO IS NOT NULL
	PRINT 'Migración de promocion terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_caja
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Caja(
        caja_numero,
        id_tipo_caja
      )
      SELECT --select * from gd_esquema.Maestra
        m.CAJA_NUMERO, 
        c.id_tipo_caja
      FROM gd_esquema.Maestra m
	  JOIN FRBA_SUPERMERCADO.Tipo_Caja c ON 
			c.tipo_caja_descripcion = (SELECT DISTINCT(SUBSTRING(m.CAJA_TIPO,11,20)))
      WHERE CAJA_NUMERO IS NOT NULL
	  PRINT 'Migración de caja terminada';
END
GO
--
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_domicilio
AS
BEGIN
    -- Inserción de los domicilios en la tabla Domicilio
    INSERT INTO FRBA_SUPERMERCADO.Domicilio (
        domicilio_direccion,
        id_localidad,
        id_provincia
    ) 
    SELECT
        m.SUPER_DOMICILIO,
        FRBA_SUPERMERCADO.get_localidad_id(m.SUPER_DOMICILIO) AS id_localidad,
        FRBA_SUPERMERCADO.get_provincia_id(m.SUPER_PROVINCIA) AS id_provincia
    FROM gd_esquema.Maestra m
    WHERE CLIENTE_DOMICILIO IS NOT NULL OR SUPER_DOMICILIO IS NOT NULL;
	INSERT INTO FRBA_SUPERMERCADO.Domicilio (
        domicilio_direccion,
        id_localidad,
        id_provincia
    ) 
    SELECT
        m.CLIENTE_DOMICILIO,
        FRBA_SUPERMERCADO.get_localidad_id(m.CLIENTE_LOCALIDAD),
        FRBA_SUPERMERCADO.get_provincia_id(m.CLIENTE_PROVINCIA)
    FROM gd_esquema.Maestra m
    WHERE CLIENTE_DOMICILIO IS NOT NULL;
    PRINT 'Migracion de Domicilio terminada';
    --PRINT 'Migracion de Domicilio terminada';
END;
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_Sucursal
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Sucursal (
	id_domicilio,
	id_supermercado,
	sucursal_numero -- solo el numero
	)
	SELECT
		FRBA_SUPERMERCADO.get_domicilio_id(m.SUPER_DOMICILIO),
		s.id_supermercado,
		(SELECT DISTINCT(SUBSTRING(m.SUCURSAL_NOMBRE,11,20)))		
	FROM gd_esquema.Maestra m
	JOIN FRBA_SUPERMERCADO.Supermercado s ON m.SUPER_CUIT = s.super_cuit
	WHERE 1 IS NOT NULL
	PRINT 'Migración de sucursal terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_cliente
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Cliente(
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
		FRBA_SUPERMERCADO.get_domicilio_id(m.CLIENTE_DOMICILIO),
		m.CLIENTE_NOMBRE,
		m.CLIENTE_APELLIDO,
		m.CLIENTE_FECHA_REGISTRO,
		m.CLIENTE_MAIL,
		m.CLIENTE_FECHA_NACIMIENTO
	FROM gd_esquema.Maestra m
	WHERE m.CLIENTE_DNI IS NOT NULL
	ORDER BY m.CLIENTE_DNI
	PRINT 'Migración de cliente terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_Empleado
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Empleado(
		id_sucursal,
    	empleado_nombre,
		empleado_apellido,
		empleado_dni,
		empleado_fecha_registro,
		empleado_fecha_nacimiento,
		empleado_email,
		empleado_telefono
	)
	SELECT 
		FRBA_SUPERMERCADO.get_sucursal_id(m.SUCURSAL_DIRECCION),
		m.EMPLEADO_NOMBRE,
		m.EMPLEADO_APELLIDO,
		m.EMPLEADO_DNI,
		m.EMPLEADO_FECHA_REGISTRO,
		m.CLIENTE_FECHA_REGISTRO,
		m.EMPLEADO_MAIL,
		m.EMPLEADO_TELEFONO
	FROM gd_esquema.Maestra m
	WHERE m.EMPLEADO_DNI IS NOT NULL
	PRINT 'Migración de empleado terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_Producto
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Producto(
		id_producto, -- PRODUCTO_NOMBRE
		id_producto_categoria,
		id_producto_subcategoria,
		id_marca,
		producto_descripcion,
		producto_precio
	)
	SELECT 
		(CAST(SUBSTRING(m.PRODUCTO_NOMBRE,8,20) AS DECIMAL(11,0))),
		(CAST(SUBSTRING(m.PRODUCTO_CATEGORIA, 13,20) AS INT)),
		(CAST(SUBSTRING(m.PRODUCTO_SUB_CATEGORIA, 16,20) AS INT)),
		(CAST(SUBSTRING(m.PRODUCTO_MARCA,9,10) AS DECIMAL(10,0))),
		(CAST(SUBSTRING(m.PRODUCTO_DESCRIPCION,29,70) AS DECIMAL(11,0))),
		m.PRODUCTO_PRECIO
	FROM gd_esquema.Maestra m
	WHERE PRODUCTO_NOMBRE IS NOT NULL
	PRINT 'Migración de producto terminada';
END
GO

----- EJECUCION DE LOS PROCEDURES -----

----- COSAS PARA PROBAR -----
--select * from gd_esquema.Maestra
