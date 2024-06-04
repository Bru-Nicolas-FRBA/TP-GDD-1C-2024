-- Creación de nuevas tablas para el modelo de BI
CREATE TABLE BI_Cliente (
    id_cliente INT PRIMARY KEY,
    cliente_nombre VARCHAR(100),
    cliente_apellido VARCHAR(100),
    cliente_fecha_nacimiento DATE,
    cliente_mail VARCHAR(255),
    
);

CREATE TABLE BI_Producto (
    id_producto INT PRIMARY KEY,
    producto_nombre VARCHAR(100),
    producto_descripcion VARCHAR(100),
    producto_precio DECIMAL(10,2),
    id_producto_categoria INT,
    id_producto_subcategoria INT,
    id_marca INT,
    
);

-- Creación de vistas para el modelo de BI
CREATE VIEW BI_Venta AS
SELECT
    t.id_ticket,
    t.ticket_fecha_hora,
    c.id_cliente,
    c.cliente_nombre,
    c.cliente_apellido,
    p.id_producto,
    p.producto_nombre,
    p.producto_precio,
    
FROM
    dbo.Ticket t
    JOIN dbo.Cliente c ON t.id_cliente = c.id_cliente
    JOIN dbo.Item_Ticket it ON t.id_ticket = it.id_ticket
    JOIN dbo.Producto p ON it.id_producto = p.id_producto;


-- Creación de claves primarias y foráneas en las tablas del modelo dimensional

-- Tabla BI_Cliente
ALTER TABLE BI_Cliente
ADD CONSTRAINT PK_BI_Cliente_id_cliente PRIMARY KEY (id_cliente);

-- Tabla BI_Producto
ALTER TABLE BI_Producto
ADD CONSTRAINT PK_BI_Producto_id_producto PRIMARY KEY (id_producto);

-- Tabla BI_Venta
ALTER TABLE BI_Venta
ADD CONSTRAINT PK_BI_Venta_id_venta PRIMARY KEY (id_venta),
ADD CONSTRAINT FK_BI_Venta_id_cliente FOREIGN KEY (id_cliente) REFERENCES BI_Cliente(id_cliente),
ADD CONSTRAINT FK_BI_Venta_id_producto FOREIGN KEY (id_producto) REFERENCES BI_Producto(id_producto);


-- Migración de datos al modelo dimensional

-- Tabla BI_Cliente
INSERT INTO BI_Cliente (id_cliente, cliente_dni, cliente_nombre, cliente_apellido, cliente_fecha_registro, cliente_mail, cliente_fecha_nacimiento)
SELECT id_cliente, cliente_dni, cliente_nombre, cliente_apellido, cliente_fecha_registro, cliente_mail, cliente_fecha_nacimiento
FROM dbo.Cliente;

-- Tabla BI_Producto
INSERT INTO BI_Producto (id_producto, producto_nombre, producto_descripcion, producto_precio)
SELECT id_producto, producto_nombre, producto_descripcion, producto_precio
FROM dbo.Producto;

-- Tabla BI_Venta
INSERT INTO BI_Venta (id_venta, id_cliente, id_producto, fecha_venta, cantidad_vendida, monto_total)
SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad_vendida, monto_total
FROM dbo.Venta;



-- Vista para calcular el ticket promedio mensual por localidad, año y mes
CREATE VIEW Vista_Ticket_Promedio_Mensual AS
SELECT
    YEAR(t.ticket_fecha_hora) AS anio,
    MONTH(t.ticket_fecha_hora) AS mes,
    l.localidad_nombre,
    AVG(it.item_precio_total) AS ticket_promedio
FROM
    Ticket t
    JOIN Cliente c ON t.id_cliente = c.id_cliente
    JOIN Localidad l ON c.id_localidad = l.id_localidad
    JOIN Item_Ticket it ON t.id_ticket = it.id_ticket
GROUP BY
    YEAR(t.ticket_fecha_hora),
    MONTH(t.ticket_fecha_hora),
    l.localidad_nombre;

-- Vista para calcular la cantidad de unidades promedio por turno para cada cuatrimestre de cada año
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