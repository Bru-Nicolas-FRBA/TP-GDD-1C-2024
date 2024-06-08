USE [GD1C2024]
GO

/* COSAS DE MIGRACION */
--revisar en que casos conviene usar JOIN o FUNCION, porque JOIN conviene con tabla grande, FUNCION conviene con tabla chiquita 
--Falta calcular bien el valor del descuento de la promo porque para c/ticket varia por el precio
--Creo que la funcion get_sucursal_id es alpedo y es necesario usar JOINs
--Ver si get_cliente_id se puede hacer mejor, alpedo que dependa del DNI
--Revisar ticket_x_pago porque dudo mucho

/* COSAS QUE DICE EN LA CONSIGNA IMPORTANTES*/
--No se puede modificar los datos, entonces los CAST y SUBSTRING tienen que irse y nos manenamos sin eso

------------------------------------------------------------------------------------------------
----- DROPEO DE TABLAS (respetar orden establecido) -----
------------------------------------------------------------------------------------------------

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion_x_producto)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_promocion_x_producto; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion_x_item_ticekt)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_promocion_x_item_ticekt; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_ticket_x_pago)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_ticket_x_pago; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_regla_x_promocion)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_regla_x_promocion; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_pago)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_pago; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_item_ticket)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_item_ticket; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_envio)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_envio; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_ticket)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_ticket; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_producto)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_producto; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_empleado)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_empleado; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_cliente)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_cliente; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_sucursal)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_sucursal; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_caja)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_caja; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_promocion; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_localidad)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_localidad; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_provincia)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_provincia; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_comprobante)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_tipo_comprobante; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_caja)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_tipo_caja; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_supermercado)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_supermercado; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_regla)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_regla; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_descuento)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_descuento; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_medio_pago)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_tipo_medio_pago; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_marca)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_marca; end

if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_subcategoria)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_subcategoria; end


if exists (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_categoria)
begin DROP TABLE FRBA_SUPERMERCADO.migrar_categoria; end
GO

CREATE SCHEMA [FRBA_SUPERMERCADO]
GO
------------------------------------------------------------------------------------------------
----- CREACIÓN DE TABLAS (respetar orden establecido) -----
------------------------------------------------------------------------------------------------

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
	id_promo INT PRIMARY KEY NOT NULL,
	promo_descripcion VARCHAR(50) UNIQUE NOT NULL,
	promo_fecha_inicio DATE NOT NULL,
	promo_fecha_fin DATE NOT NULL,
	promo_valor_descuento DECIMAL(6,2) NOT NULL, 
);
------------------------------------------------------------------------------------------------
----- Tablas con Clave foranea -----
------------------------------------------------------------------------------------------------
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
---
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
---
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
------------------------------------------------------------------------------------------------
----- TABLAS COMPOSICION -----
------------------------------------------------------------------------------------------------
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
GO
------------------------------------------------------------------------------------------------
----- FUNCIONES PARA USAR -----
------------------------------------------------------------------------------------------------
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
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_empleado_id(@mail VARCHAR(30))
RETURNS INT
AS
BEGIN
	DECLARE @id_empleado INT;
	
    SELECT @id_empleado = id_empleado
    FROM FRBA_SUPERMERCADO.Empleado
    WHERE empleado_email = @mail;
    RETURN @id_empleado;
END;
GO
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_cliente_id(@dni INT)
RETURNS INT
AS
BEGIN
	DECLARE @id_cliente INT;
	
    SELECT @id_cliente = id_cliente
    FROM FRBA_SUPERMERCADO.Cliente
    WHERE cliente_dni = @dni;
    RETURN @id_cliente;
END;
GO
--
CREATE FUNCTION FRBA_SUPERMERCADO.get_regla_id(@descripcion INT)
RETURNS INT
AS
BEGIN
	DECLARE @id_regla INT;
	
    SELECT @id_regla = id_regla
    FROM FRBA_SUPERMERCADO.Regla
    WHERE regla_descripcion = @descripcion;
    RETURN @id_regla;
END;
GO
------------------------------------------------------------------------------------------------
----- PROCEDIMIENTOS DE MIGRACION (respetar orden establecido) -----
------------------------------------------------------------------------------------------------

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
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_provincia
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
		promo_codigo,
		promo_descripcion,
		promo_fecha_inicio,
		promo_fecha_fin,
		promo_valor_descuento -- KK FALTA CALCULARLO BIEN porque no se enciente nada
      )
      SELECT DISTINCT --esto revisar si tiene que ir o no
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
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_sucursal
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
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_empleado
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
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_producto
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
		m.PRODUCTO_NOMBRE,
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
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_ticket
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Ticket(
        id_ticket,
	    id_tipo_comprobante,
	    id_sucursal,
	    id_caja,
	    id_empleado,
	    ticket_fecha_hora,
	    ticket_subtotal,
	    ticket_total,
	    ticket_monto_total_promociones_aplicadas,
	    ticket_monto_total_descuentos_aplicados
    )
	SELECT DISTINCT
        m.TICKET_NUMERO,
        tc.id_tipo_comprobante,
        FRBA_SUPERMERCADO.get_sucursal_id(m.SUCURSAL_DIRECCION),
        caja.id_caja,
        FRBA_SUPERMERCADO.get_empleado_id(m.EMPLEADO_MAIL),
        m.TICKET_FECHA_HORA,
        m.TICKET_SUBTOTAL_PRODUCTOS,
        (m.TICKET_TOTAL_DESCUENTO_APLICADO + m.TICKET_TOTAL_DESCUENTO_APLICADO_MP),
        m.TICKET_TOTAL_ENVIO
	FROM gd_esquema.Maestra m
        JOIN FRBA_SUPERMERCADO.Tipo_Caja caja ON m.CAJA_NUMERO = caja.caja_numero
        JOIN FRBA_SUPERMERCADO.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
	WHERE m.TICKET_NUMERO IS NOT NULL
	PRINT 'Migración de Ticket terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_envio
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Envio(
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
        m.TICKET_NUMERO,
        FRBA_SUPERMERCADO.get_cliente_id(m.CLIENTE_DNI),
        m.ENVIO_FECHA_PROGRAMADA,
        m.ENVIO_HORA_INICIO,
        m.ENVIO_HORA_FIN,
        m.ENVIO_FECHA_ENTREGA,
        m.ENVIO_ESTADO,
        m.ENVIO_COSTO
	FROM gd_esquema.Maestra m
	WHERE
        m.ENVIO_HORA_INICIO IS NOT NULL
        AND m.ENVIO_HORA_FIN IS NOT NULL
        AND m.ENVIO_FECHA_ENTREGA IS NOT NULL
    
	PRINT 'Migración de envio terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_item_ticket
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Item_Ticket(
        id_ticket, --ticketunmero
        id_producto,
        id_tipo_comprobante,
        id_sucursal,
        id_promocion,
        item_ticket_cantidad,
        item_ticket_precio
    )
	SELECT 
        m.TICKET_NUMERO,
        m.PRODUCTO_NOMBRE, --tiene letras    
        tc.id_tipo_comprobante,
        FRBA_SUPERMERCADO.get_sucursal_id(m.SUCURSAL_DIRECCION),
        m.PROMO_CODIGO,
        m. TICKET_DET_CANTIDAD,
        m.TICKET_DET_PRECIO
    FROM gd_esquema.Maestra m
        JOIN FRBA_SUPERMERCADO.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
	WHERE m.TICKET_NUMERO IS NOT NULL
	PRINT 'Migración de item ticket terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_pago
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.pago(
        id_tipo_medio_de_pago,
        id_cliente,
        id_descuento,
		pago_fecha,
        pago_importe,
        pago_numero_tarjeta,
        medio_de_pago_cuotas,
        medio_de_pago_fecha_vencimiento,
        medio_de_pago_descuento_aplicado
    )
	SELECT
        mp.medio_de_pago_detalle,
        FRBA_SUPERMERCADO.get_cliente_id(m.CLIENTE_DNI),
        m.DESCUENTO_CODIGO,
		m.PAGO_FECHA,
        m.PAGO_IMPORTE,
        m.PAGO_TARJETA_NRO,
        m.PAGO_TARJETA_CUOTAS,
        m.PAGO_TARJETA_FECHA_VENC,
        m.PAGO_DESCUENTO_APLICADO
    FROM gd_esquema.Maestra m
        JOIN FRBA_SUPERMERCADO.Tipo_medio_de_pago mp ON m.PAGO_MEDIO_PAGO = mp.medio_de_pago_detalle
	WHERE m.TICKET_NUMERO IS NOT NULL
	PRINT 'Migración de Pago terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_regla_x_promocion
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Regla_x_Promocion(
		id_promocion,
		id_regla
	)
	SELECT 
		m.PROMO_CODIGO,
		FRBA_SUPERMERCADO.get_regla_id(m.REGLA_DESCRIPCION)
	FROM gd_esquema.Maestra m
	WHERE 
		m.PROMO_CODIGO IS NOT NULL
		AND 2 IS NOT NULL
	PRINT 'Migración de regla x promocion terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_ticket_x_pago
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Ticket_X_Pago(
		id_ticket,
		id_pago
	)
	SELECT
		m.TICKET_NUMERO,
		p.id_pago
	FROM gd_esquema.Maestra m
		JOIN FRBA_SUPERMERCADO.Pago p ON --No creo que un mismo cliente pueda hacer 2 pagos en el MISMO SEGUNDO
			m.FRBA_SUPERMERCADO.get_cliente_id(m.CLIENTE_DNI) = p.id_cliente 
			AND m.PAGO_FECHA = p.pago_fecha
	WHERE m.TICKET_NUMERO IS NOT NULL
	PRINT 'Migración de ticket_x_pago terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_promocion_x_item_ticekt
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Promocion_X_Item_Ticket(
		id_promocion,
		id_item_ticket
	)
	SELECT
		m.PROMO_CODIGO,
		id.id_item_ticket
	FROM gd_esquema.Maestra m 
		JOIN FRBA_SUPERMERCADO.Item_Ticket it ON
			m.TICKET_NUMERO = it.id_ticket
			AND m.PRODUCTO_NOMBRE = it.id_producto
			AND m.PROMO_CODIGO = it.id_promocion
	WHERE 
		m.TICKET_NUMERO IS NOT NULL
		AND m.PROMO_CODIGO IS NOT NULL 
	PRINT 'Migración de promo_x_item_ticket terminada';
END
GO
--
CREATE PROCEDURE FRBA_SUPERMERCADO.migrar_promocion_x_producto
AS
BEGIN
	INSERT INTO FRBA_SUPERMERCADO.Promocion_X_Producto(
		id_promocion,
		id_producto
	)
	SELECT
		 m.PROMO_CODIGO,
		 m.PRODUCTO_NOMBRE
	FROM gd_esquema.Maestra m
	WHERE 
		m.TICKET_NUMERO IS NOT NULL
		AND m.PROMO_CODIGO IS NOT NULL
	PRINT 'Migración de promocion_x_producto terminada';
END
GO

------------------------------------------------------------------------------------------------
----- EJECUCION DE LOS PROCEDURES -----
------------------------------------------------------------------------------------------------
BEGIN TRANSACTION
BEGIN TRY
	----- TABLAS BASE -----
	EXEC FRBA_SUPERMERCADO.migrar_categoria
	EXEC FRBA_SUPERMERCADO.migrar_subcategoria
	EXEC FRBA_SUPERMERCADO.migrar_marca
	EXEC FRBA_SUPERMERCADO.migrar_tipo_medio_pago
	EXEC FRBA_SUPERMERCADO.migrar_descuento
	EXEC FRBA_SUPERMERCADO.migrar_regla
	EXEC FRBA_SUPERMERCADO.migrar_supermercado
	EXEC FRBA_SUPERMERCADO.migrar_tipo_caja
	EXEC FRBA_SUPERMERCADO.migrar_tipo_comprobante
	EXEC FRBA_SUPERMERCADO.migrar_provincia
	EXEC FRBA_SUPERMERCADO.migrar_localidad
	EXEC FRBA_SUPERMERCADO.migrar_promocion
	----- TABLAS CON CLAVE FORANEA -----	
	EXEC FRBA_SUPERMERCADO.migrar_caja
	EXEC FRBA_SUPERMERCADO.migrar_domicilio
	EXEC FRBA_SUPERMERCADO.migrar_sucursal
	EXEC FRBA_SUPERMERCADO.migrar_cliente
	EXEC FRBA_SUPERMERCADO.migrar_empleado
	EXEC FRBA_SUPERMERCADO.migrar_producto
	EXEC FRBA_SUPERMERCADO.migrar_ticket
	EXEC FRBA_SUPERMERCADO.migrar_envio
	EXEC FRBA_SUPERMERCADO.migrar_item_ticket
	EXEC FRBA_SUPERMERCADO.migrar_pago
	----- TABLAS COMPOSICION -----
	EXEC FRBA_SUPERMERCADO.migrar_regla_x_promocion
	EXEC FRBA_SUPERMERCADO.migrar_ticket_x_pago
	EXEC FRBA_SUPERMERCADO.migrar_promocion_x_item_ticekt
	EXEC FRBA_SUPERMERCADO.migrar_promocion_x_producto
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION;
	RAISERROR ('Error al migrar tablas. Chequear si las tablas estan vacias.', 14, 1)
END CATCH;

IF (
	EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_categoria) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_subcategoria)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_marca)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_medio_pago)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_descuento) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_regla) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_supermercado) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_caja) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_tipo_comprobante) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_provincia) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_localidad) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_caja) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_domicilio) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_sucursal) 
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_cliente)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_empleado)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_producto)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_ticket)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_envio)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_item_ticket)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_pago)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_regla_x_promocion)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_ticket_x_pago)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion_x_item_ticekt)
	AND EXISTS (SELECT 1 FROM FRBA_SUPERMERCADO.migrar_promocion_x_producto)
)
	BEGIN
		PRINT 'Las tablas fueron migradas correctamente.'
		COMMIT TRANSACTION;
	END
ELSE
	BEGIN
		ROLLBACK TRANSACTION;
		RAISERROR ('Error al migrar una o más tablas. Ninguna operación no fue realizada.', 14, 1)
	END
GO
