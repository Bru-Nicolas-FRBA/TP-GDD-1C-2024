USE [GD1C2024]
GO

/****** Object:  Schema [FRBA_SUPERMERCADO]    Script Date: 14/10/2022 21:31:23 ******/
CREATE SCHEMA [FRBA_SUPERMERCADO]
GO

----- CREACIÓN DE TABLAS  -----
--
CREATE TABLE FRBA_SUPERMERCADO.Producto_categoria (
	id_producto_categoria INT PRIMARY KEY IDENTITY(1,1),
	producto_categoria_detalle VARCHAR(100) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Producto_subcategoria (
    id_producto_subcategoria INT PRIMARY KEY IDENTITY(1,1),
    producto_subcategoria_detalle VARCHAR(100) UNIQUE NOT NULL, 
);
--
CREATE TABLE FRBA_SUPERMERCADO.Producto_marca (
	id_producto_marca INT PRIMARY KEY IDENTITY(1,1),
	producto_marca_detalle VARCHAR(100) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Cliente_Contacto (
	id_cliente_contacto INT PRIMARY KEY IDENTITY(1,1),
	cliente_contacto_numero VARCHAR(20) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Tipo_medio_de_pago (
	id_tipo_medio_pago INT PRIMARY KEY IDENTITY(1,1),
	medio_de_pago_detalle VARCHAR(100) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Descuento (
	descuento_codigo INT PRIMARY KEY NOT NULL,
	descuento_descripcion VARCHAR(100) NOT NULL,
	descuento_fecha_inicio DATE NOT NULL,
	descuento_fecha_fin DATE NOT NULL,
	descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
	descuento_tope DECIMAL(10, 2) NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Regla (
	id_regla INT PRIMARY KEY IDENTITY(1,1),
	regla_cantidad_aplicable INT NOT NULL,
	regla_descripcion VARCHAR(50) UNIQUE NOT NULL,
	regla_cantidad_aplicable_descuento INT NOT NULL,
	regla_cantidad_maxima INT NOT NULL,
	regla_misma_marca BIT NOT NULL,
	regla_mismo_producto BIT NOT NULL,
	regla_descuento_aplicable_prod DECIMAL(3, 2) NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Supermercado (
	super_id INT PRIMARY KEY IDENTITY(1,1),
	super_nombre VARCHAR(50) UNIQUE NOT NULL,
	super_razon_social VARCHAR(100) NOT NULL,
	super_cuit VARCHAR(30) NOT NULL,
	super_iibb VARCHAR(30) NOT NULL, --Ingr. Brut. N°: 133452135
	super_fecha_inicio_actividad DATE NOT NULL,
	super_condicion_fiscal VARCHAR(50) NOT NULL
);
--
CREATE TABLE FRBA_SUPERMERCADO.Tipo_Caja(
	id_tipo_caja INT PRIMARY KEY IDENTITY(1,1),
	tipo_caja_descripcion VARCHAR(50) UNIQUE NOT NULL,
);
--
 CREATE TABLE FRBA_SUPERMERCADO.Tipo_Comprobante(
	id_tipo_comprobante INT PRIMARY KEY IDENTITY(1,1),
	tipo_comprobante_nombre VARCHAR (1), --caracter
);
--
CREATE TABLE FRBA_SUPERMERCADO.Provincia(
	id_provincia INT PRIMARY KEY IDENTITY(1,1),
	provincia_nombre VARCHAR(50) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Localidad(
	id_localidad INT PRIMARY KEY IDENTITY(1,1),
	localidad_nombre VARCHAR(50) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Promocion (
	id_promocion INT PRIMARY KEY,
	promo_descripcion VARCHAR(50) UNIQUE NOT NULL,
	promo_fecha_inicio DATE NOT NULL,
	promo_fecha_fin DATE NOT NULL,
);
----- Tablas con Clave foranea
CREATE TABLE FRBA_SUPERMERCADO.Caja(
	id_caja INT PRIMARY KEY IDENTITY(1,1),
	caja_numero INT, 	
	id_tipo_caja INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Tipo_Caja (id_tipo_caja)
);
--
CREATE TABLE FRBA_SUPERMERCADO.Domicilio (
	id_domicilio INT PRIMARY KEY IDENTITY(1,1),
	id_localidad INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Localidad(id_localidad) NOT NULL,
	id_provincia INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Provincia(id_provincia) NOT NULL,
	domicilio_direccion VARCHAR(100) NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Sucursal (
	id_sucursal INT PRIMARY KEY IDENTITY(1,1),
	id_domicilio INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Domicilio(id_domicilio) NOT NULL,
	id_supermercado INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Supermercado(super_id) NOT NULL,
	sucursal_numero INT NOT NULL, -- solo el numero
);
--
CREATE TABLE FRBA_SUPERMERCADO.Cliente(
	id_cliente INT PRIMARY KEY IDENTITY(1,1),
	cliente_dni INT NOT NULL,
	cliente_id_domicilio INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Domicilio(id_domicilio) NOT NULL,
	cliente_id_contacto INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Cliente_Contacto(id_cliente_contacto) NOT NULL,		
	cliente_nombre VARCHAR(100) NOT NULL,
	cliente_apellido VARCHAR(100) NOT NULL,
	cliente_fecha_registro DATE NOT NULL,
	cliente_mail VARCHAR(100) UNIQUE NOT NULL,
	cliente_fecha_nacimiento DATE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Empleado(
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    id_sucursal INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal) NOT NULL,
    empleado_nombre VARCHAR(15) NOT NULL,
    empleado_apellido VARCHAR(30) NOT NULL,
    empleado_dni INT NOT NULL,
    empleado_fecha_registro DATE NOT NULL,
    empleado_fecha_nacimiento DATE NOT NULL,
    empleado_email VARCHAR (30) UNIQUE NOT NULL,
);
--
CREATE TABLE FRBA_SUPERMERCADO.Producto (
	id_producto INT PRIMARY KEY, -- PRODUCTO_NOMBRE
	id_producto_categoria INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_categoria(id_producto_categoria) NOT NULL,
	id_producto_subcategoria INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_subcategoria(id_producto_subcategoria) NOT NULL,
	id_marca INT FOREIGN KEY REFERENCES FRBA_SUPERMERCADO.Producto_marca(id_producto_marca) NOT NULL,
	producto_descripcion VARCHAR(100) NOT NULL,
	producto_precio DECIMAL(10,2) NOT NULL,
);
--
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
	id_sucursaL INT FOREIGN KEY (id_sucursal)  REFERENCES FRBA_SUPERMERCADO.Sucursal (id_sucursal) NOT NULL,
	id_promocion INT FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion (id_promocion) NOT NULL,
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
	CONSTRAINT FK_Regla_X_Promocion_Promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promocion),
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
	CONSTRAINT FK_Promocion_X_ItemTicket_Promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promocion),
	CONSTRAINT FK_Promocion_X_ItemTicket_Item_Ticket FOREIGN KEY (id_item_ticket) REFERENCES FRBA_SUPERMERCADO.Item_Ticket(id_item_ticket)
);
--
CREATE TABLE FRBA_SUPERMERCADO.Promocion_X_Producto (
	id_promocion INT,
	id_producto INT,
	CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_producto),
	CONSTRAINT FK_Promoxion_X_Producto_id_promocion FOREIGN KEY (id_promocion) REFERENCES FRBA_SUPERMERCADO.Promocion(id_promocion),
	CONSTRAINT FK_Promoxion_X_Producto_id_producto FOREIGN KEY (id_producto) REFERENCES FRBA_SUPERMERCADO.Producto(id_producto)
);
--

----- FUNCIONES PARA USAR -----

----- PROCEDIMIENTOS DE MIGRACION -----

----- EJECUCION DE LOS PROCEDURES -----

----- COSAS PARA PROBAR -----
--select * from gd_esquema.Maestra