/*------------------------------------PROCEDIMIENTOS PARA MIGRAR TABLAS------------------------------------*/
--primero veamos de crear tablas
--despues procedimientos para migrar foraneas
--procedimimiento para ejecutar los procedeure
--codigo muerto para hacer todos los drop table (PROBAR CODIGO)

/*------------------------------------TABLAS SIN CLAVE FORANEA------------------------------------*/
CREATE PROCEDURE gd_esquema.migrar_producto_categoria
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Producto_categoria (
        id_producto_categoria INT PRIMARY KEY IDENTITY(1,1),
        producto_categoria_detalle VARCHAR(100) UNIQUE NOT NULL,
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Producto_categoria(producto_categoria_detalle)
        SELECT DISTINCT PRODUCTO_CATEGORIA
        FROM gd_esquema.Maestra
        WHERE PRODUCTO_CATEGORIA IS NOT NULL
      PRINT 'Migración de migrar_producto_categoria terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_producto_subcategoria
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
        CREATE TABLE gd_esquema.Producto_subcategoria (
          id_producto_subcategoria INT PRIMARY KEY IDENTITY(1,1),
          producto_subcategoria_detalle VARCHAR(100) UNIQUE NOT NULL, 
        );
      --rellenar tabla
      INSERT INTO gd_esquema.Producto_subcategoria(producto_subcategoria_detalle)
        SELECT DISTINCT PRODUCTO_SUB_CATEGORIA
        FROM gd_esquema.Maestra
        WHERE PRODUCTO_SUB_CATEGORIA IS NOT NULL
      PRINT 'Migración de migrar_producto_subcategoria terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_producto_marca
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Producto_marca (
        id_producto_marca INT PRIMARY KEY IDENTITY(1,1),
        producto_marca_detalle VARCHAR(100) UNIQUE NOT NULL,
        );
      --rellenar tabla
      INSERT INTO gd_esquema.Producto_marca(producto_marca_detalle)
        SELECT DISTINCT PRODUCTO_MARCA
        FROM gd_esquema.Maestra
        WHERE PRODUCTO_MARCA IS NOT NULL
      PRINT 'Migración de migrar_producto_marca terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_cliente_contacto
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
        CREATE TABLE gd_esquema.Cliente_Contacto (
        id_cliente_contacto INT PRIMARY KEY IDENTITY(1,1),
        cliente_contacto_numero VARCHAR(20) UNIQUE NOT NULL,
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Cliente_Contacto(cliente_contacto_numero)
        SELECT DISTINCT CLIENTE_TELEFONO
        FROM gd_esquema.Maestra
        WHERE CLIENTE_TELEFONO IS NOT NULL
      PRINT 'Migración de migrar_cliente_contacto terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_tipo_medio_de_pago
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Tipo_medio_de_pago (
        id_tipo_medio_pago INT PRIMARY KEY IDENTITY(1,1),
        tipo_medio_pago_nombre VARCHAR(255) UNIQUE NOT NULL,
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Tipo_medio_de_pago(tipo_medio_pago_nombre)
        SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO
        FROM gd_esquema.Maestra
        WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL
      PRINT 'Migración de migrar_tipo_medio_de_pago terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_descuento
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Descuento (
        --id_descuento INT PRIMARY KEY IDENTITY(1,1),
        descuento_codigo INT NOT NULL,
        descuento_descripcion VARCHAR(255) NOT NULL,
        descuento_fecha_inicio DATE NOT NULL,
        descuento_fecha_fin DATE NOT NULL,
        descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
        descuento_tope DECIMAL(10, 2) NOT NULL,

        CONSTRAINT CHK_Descuento_fechas CHECK (fecha_fin >= fecha_inicio),
        CONSTRAINT CHK_Descuento_valor_porcentual CHECK (descuento_valor_porcentual_a_aplicar >= 0 AND descuento_valor_porcentual_a_aplicar <= 99.99),
        CONSTRAINT CHK_Descuento_tope CHECK (descuento_tope >= 0)
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Descuento(
        descuento_codigo,
        descuento_descripcion,
        descuento_fecha_inicio,
        descuento_fecha_fin,
        descuento_valor_porcentual_a_aplicar,
        descuento_tope
      )
      SELECT
        DESCUENTO_CODIGO,
        DESCUENTO_DESCRIPCION,
        DESCUENTO_FECHA_INICIO,
        DESCUENTO_FECHA_FIN,
        DESCUENTO_PORCENTAJE_DESC,
        DESCUENTO_TOPE
      FROM gd_esquema.Maestra
      WHERE DESCUENTO_CODIGO IS NOT NULL
        AND DESCUENTO_PORCENTAJE_DESC IS NOT NULL
      PRINT 'Migración de migrar_descuento terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_regla
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Regla (
        id_regla INT PRIMARY KEY IDENTITY(1,1),
        regla_cantidad_aplicable INT NOT NULL,
        regla_descripcion VARCHAR(255) UNIQUE NOT NULL,
        regla_cantidad_aplicable_descuento INT NOT NULL,
        regla_cantidad_maxima INT NOT NULL,
        regla_misma_marca BOOLEAN NOT NULL,
        regla_mismo_producto BOOLEAN NOT NULL,
        regla_descuento_aplicable_prod DECIMAL(3, 2) NOT NULL,

        CONSTRAINT CHK_Regla_descuento_aplicable_prod CHECK (regla_descuento_aplicable_prod >= 0 AND regla_descuento_aplicable_prod <= 0.99)
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Regla(
        regla_cantidad_aplicable,
        regla_descripcion,
        regla_cantidad_aplicable_descuento,
        regla_cantidad_maxima,
        regla_misma_marca,
        regla_mismo_producto,
        regla_descuento_aplicable_prod
      )
      SELECT
        REGLA_CANT_APLICABLE_REGLA,
        REGLA_DESCRIPCION,
        REGLA_CANT_APLICA_DESCUENTO,
        REGLA_CANT_MAX_PROD,
        REGLA_APLICA_MISMA_MARCA,
        REGLA_APLICA_MISMO_PROD,
        REGLA_DESCUENTO_APLICABLE_PROD
      FROM gd_esquema.Maestra
      WHERE REGLA_DESCRIPCION IS NOT NULL
      PRINT 'Migración de migrar_regla terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_supermercado
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Supermercado (
        super_id INT PRIMARY KEY IDENTITY(1,1),
        super_nombre VARCHAR(255) UNIQUE NOT NULL,
        super_razon_social VARCHAR(255) NOT NULL,
        super_cuit VARCHAR(20) NOT NULL,
        super_iibb VARCHAR(20) NOT NULL,
        super_fecha_inicio_actividad DATE NOT NULL,
        super_condicion_fiscal VARCHAR(50) NOT NULL
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Supermercado(
        super_nombre,
        super_razon_social,
        super_cuit,
        super_iibb,
        super_fecha_inicio_actividad,
        super_condicion_fiscal
      )
      SELECT
        SUPER_NOMBRE,
        SUPER_RAZON_SOC,
        SUPER_CUIT,
        SUPER_IIBB,
        SUPER_FECHA_INI_ACTIVIDAD,
        SUPER_CONDICION_FISCAL
        /*Esto no lo guardamos aca, sino en la tabla gd_esquema.Domicilio*/
        --SUPER_DOMICILIO
        /*Estos los guardamos cada uno en sus respectivas tablas*/
        --SUPER_LOCALIDAD
        --SUPER_PROVINCIA
      FROM gd_esquema.Maestra
      WHERE SUPER_NOMBRE IS NOT NULL
        AND SUPER_RAZON_SOC IS NOT NULL
        AND SUPER_CUIT IS NOT NULL
        AND SUPER_IIBB IS NOT NULL
        AND SUPER_CONDICION_FISCAL IS NOT NULL
      PRINT 'Migración de migrar_supermercado terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_tipo_caja
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Tipo_Caja(
        id_tipo_caja INT PRIMARY KEY IDENTITY(1,1),
        tipo_caja_descripcion VARCHAR(50) UNIQUE NOT NULL,
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Tipo_Caja(tipo_caja_descripcion)
        SELECT DISTINCT(CAJA_TIPO)
        FROM gd_esquema.Maestra
        WHERE CAJA_TIPO IS NOT NULL
      PRINT 'Migración de migrar_tipo_caja terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_tipo_comprobante
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Tipo_Comprobante(
        id_tipo_comprobante INT PRIMARY KEY IDENTITY(1,1),
        tipo_comprobante_nombre VARCHAR (1), --caracter
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Tipo_Comprobante(tipo_comprobante_nombre)
        SELECT DISTINCT(TICKET_TIPO_COMPROBANTE)
        FROM gd_esquema.Maestra
        WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
      PRINT 'Migración de migrar_tipo_comprobante terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_provincia
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
        CREATE TABLE gd_esquema.Provincia(
        id_provincia INT PRIMARY KEY IDENTITY(1,1),
        provincia_nombre VARCHAR(100) UNIQUE NOT NULL,
      );
      --rellenar tabla
      /*Esta en campos distintos asi que los sacamos de las dos tablas*/
      INSERT INTO gd_esquema.Provincia(provincia_nombre)
        SELECT DISTINCT SUCURSAL_PROVINCIA
        FROM gd_esquema.Maestra
        WHERE SUCURSAL_PROVINCIA IS NOT NULL;
      INSERT INTO gd_esquema.Provincia(provincia_nombre)
        SELECT DISTINCT SUPER_PROVINCIA
        FROM gd_esquema.Maestra
        WHERE SUPER_PROVINCIA IS NOT NULL
          AND SUPER_PROVINCIA NOT IN (SELECT DISTINCT provincia_nombre FROM gd_esquema.Provincia);
      INSERT INTO gd_esquema.Provincia(provincia_nombre)
        SELECT DISTINCT CLIENTE_PROVINCIA
        FROM gd_esquema.Maestra
        WHERE CLIENTE_PROVINCIA IS NOT NULL
          AND CLIENTE_PROVINCIA NOT IN (SELECT DISTINCT provincia_nombre FROM gd_esquema.Provincia);
      PRINT 'Migración de migrar_provincia terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_localidad
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
        CREATE TABLE gd_esquema.Localidad(
          id_localidad INT PRIMARY KEY IDENTITY(1,1),
          localidad_nombre VARCHAR(100) UNIQUE NOT NULL,
        );
      --rellenar tabla
      /*Esta en campos distintos asi que los sacamos de las dos tablas*/
      INSERT INTO gd_esquema.Localidad(localidad_nombre)
        SELECT DISTINCT SUCURSAL_LOCALIDAD
        FROM gd_esquema.Maestra
        WHERE SUCURSAL_LOCALIDAD IS NOT NULL;
      INSERT INTO gd_esquema.Localidad(localidad_nombre)
        SELECT DISTINCT SUPER_LOCALIDAD
        FROM gd_esquema.Maestra
        WHERE SUPER_LOCALIDAD IS NOT NULL
          AND SUPER_LOCALIDAD NOT IN (SELECT DISTINCT localidad_nombre FROM gd_esquema.Localidad);
      INSERT INTO gd_esquema.Localidad(localidad_nombre)
        SELECT DISTINCT CLIENTE_LOCALIDAD
        FROM gd_esquema.Maestra
        WHERE CLIENTE_LOCALIDAD IS NOT NULL
          AND CLIENTE_LOCALIDAD NOT IN (SELECT DISTINCT localidad_nombre FROM gd_esquema.Localidad);
      PRINT 'Migración de migrar_localidad terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_promocion
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Promocion (
        id_promocion INT PRIMARY KEY,
        promo_descripcion VARCHAR(255) UNIQUE NOT NULL,
        promo_fecha_inicio DATE NOT NULL,
        promo_fecha_fin DATE NOT NULL,
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Promocion(
        id_promocion,
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
          AND PROMOCION_DESCRIPCION IS NOT NULL
          AND PROMO_APLICADA_DESCUENTO IS NOT NULL
    PRINT 'Migración de migrar_promocion terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
/*------------------------------------TABLAS CON CLAVE FORANEA------------------------------------*/
------------------------------------------------------------------------------------------------------------------------------------------------    
--kk
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_Empleado
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Empleado(
        id_empleado INT PRIMARY KEY IDENTITY(1,1),
        id_sucursal INT, --FK
        empleado_nombre VARCHAR(15) NOT NULL,
        empleado_apellido VARCHAR(30) NOT NULL,
        empleado_dni INT NOT NULL,
        empleado_fecha_registro DATE NOT NULL,
        empleado_fecha_nacimiento DATE NOT NULL,
        empleado_email VARCHAR (30) UNIQUE NOT NULL,

        CONSTRAINT FK_Empleado_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES gd_esquema.Sucursal (id_sucursal) 
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Empleado(
        empleado_nombre,
        empleado_apellido,
        empleado_dni,
        empleado_fecha_registro,
        empleado_fecha_nacimiento,
        empleado_email,
        id_sucursal        
      )
      SELECT
        m.EMPLEADO_NOMBRE,
        m.EMPLEADO_APELLIDO,
        m.EMPLEADO_DNI,
        m.EMPLEADO_FECHA_REGISTRO,
        m.EMPLEADO_TELEFONO,
        m.EMPLEADO_MAIL,
        m.EMPLEADO_FECHA_NACIMIENTO,
        suc.id_sucursal
        -- la id la generamos en la tabla Sucursal, hay que sacarla de ahi.
        -- Este es el chiste de las fk
      FROM gd_esquema.Maestra
      --No tenemos el id de la sucursal asi que hay que buscar combinando
      JOIN gd_esquema.Sucursal suc ON (SELECT SUBSTRING_INDEX(SUCURSAL_NOMBRE, ':', -1) FROM gd_esquema.Maestra) = suc.sucursal_numero
      -- Primero nos fijamos que la direccion coincida
      JOIN gd_esquema.Provincia p ON SUCURSAL_PROVINCIA = p.provincia_nombre 
        AND SUPER_PROVINCIA = p.provincia_nombre
      JOIN gd_esquema.Localidad l ON 
        SUCURSAL_LOCALIDAD = l.localidad_nombre 
        AND m.SUPER_LOCALIDAD = l.localidad_nombre
      JOIN gd_esquema.Domicilio d ON 
        l.id_localidad = d.id_localidad
        AND p.id_provincia = d.id_provincia
        AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_calle
        AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_numero
      --Por ultimo los datos para que no esten 2 super en la misma direccion (por ej un shopping)
      JOIN gd_esquema.Supermercado s ON
        m.SUPER_RAZON_SOC = s.super_razon_social
        AND m.SUPER_CUIT = s.super_cuit
        AND m.SUPER_IIBB = s.super_cuit
        AND m.SUPER_FECHA_INI_ACTIVIDAD = s.super_fecha_inicio_actividad
        AND m.SUPER_CONDICION_FISCAL = s.super_condicion_fiscal
      WHERE m.EMPLEADO_NOMBRE IS NOT NULL
        AND m.EMPLEADO_APELLIDO IS NOT NULL
        AND m.EMPLEADO_DNI IS NOT NULL
        AND m.EMPLEADO_FECHA_REGISTRO IS NOT NULL
        AND m.EMPLEADO_TELEFONO IS NOT NULL
        AND m.EMPLEADO_MAIL IS NOT NULL
    PRINT 'Migración de migrar_Empleado terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_caja
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Caja(
      id_caja INT PRIMARY KEY IDENTITY(1,1), -- el dni de la caja
      caja_numero INT, 	-- numero (independientemente del tipo)
      id_tipo_caja INT, -- dni del tipo de caja

      CONSTRAINT FK_Caja_id_caja_tipo FOREIGN KEY (id_tipo_caja) REFERENCES Tipo_Caja (id_tipo_caja)
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Caja(
        caja_numero,
        id_tipo_caja
      )
      SELECT
        m.CAJA_NUMERO, 
        c.id_tipo_caja
      FROM gd_esquema.Maestra m
      JOIN gd_esquema.Tipo_Caja c ON
        m.CAJA_TIPO = c.tipo_caja_descripcion
        AND m.CAJA_NUMERO = c.caja_numero 
      WHERE CAJA_NUMERO IS NOT NULL
      PRINT 'Migración de migrar_caja terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO

------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_envio
AS
BEGIN   
  BEGIN TRANSACTION;
  BEGIN TRY
    --crear tabla
    CREATE TABLE gd_esquema.Envio (
      id_envio INT PRIMARY KEY IDENTITY(1,1),
      id_ticket INT,
      id_cliente INT,
      envio_fecha_programada DATE,
      envio_horario_inicio TIME,
      envio_horario_fin TIME,
      envio_fecha_entrega DATE,
      envio_estado VARCHAR(50),
      envio_costo DECIMAL(10, 2),
      envio_estado_envio VARCHAR(50),

      CONSTRAINT FK_Envio_Ticket FOREIGN KEY (id_ticket) REFERENCES Ticket(id_ticket),
      CONSTRAINT FK_Envio_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
    );
    --rellenar tabla
    INSERT INTO gd_esquema.Envio (
      id_ticket,  -- en la tabla de Ticket
      id_cliente, -- en la tabla de Cliente
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
      JOIN gd_esquema.Ticket t ON t.id_ticket = TICKET_NUMERO
      JOIN gd_esquema.Cliente c ON c.cliente_nombre = m.CLIENTE_NOMBRE
    WHERE ENVIO_HORA_INICIO IS NOT NULL
      AND ENVIO_HORA_FIN IS NOT NULL
      AND ENVIO_FECHA_ENTREGA IS NOT NULL
      AND ENVIO_COSTO IS NOT NULL
    PRINT 'Migración de migrar_envio terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO     

------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_domicilio
AS
BEGIN   
  BEGIN TRANSACTION;
  BEGIN TRY
    --crear tabla
    CREATE TABLE gd_esquema.Domicilio (
      id_domicilio INT PRIMARY KEY IDENTITY(1,1),
      id_localidad INT NOT NULL,
      id_provincia INT NOT NULL,
      domicilio_calle VARCHAR(255) NOT NULL,
      domicilio_numero INT NOT NULL,
      --domicilio_detalle_piso VARCHAR(100),
      --domicilio_departamento VARCHAR(100)

      CONSTRAINT FK_Domicilio_Localidad FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad),
      CONSTRAINT FK_Domicilio_Provincia FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
    );
    --rellenar tabla
    INSERT INTO gd_esquema.Domicilio(
      id_localidad,
      id_provincia,
      domicilio_calle,
      domicilio_numero
      --domicilio_detalle_piso,
      --domicilio_departamento
    )
    SELECT
      l.id_localidad,
      p.id_provincia,
      --A la direccion le sacamos los numeros
      (
        SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '')
        FROM gd_esquema.Maestra
      ) AS DOMICILIO_CALLE,
      --A la direccion le sacamos las letras
      (
        SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') 
        FROM gd_esquema.Maestra
      ) AS DOMICILIO_NUMERO
    FROM gd_esquema.Maestra m
    --Aca no se si se deberia verificar con OR o AND
      JOIN gd_esquema.Provincia p ON
          m.SUCURSAL_PROVINCIA = p.provincia_nombre 
          OR m.SUPER_PROVINCIA = p.provincia_nombre
          OR m.CLIENTE_PROVINCIA = p.provincia_nombre     
      JOIN gd_esquema.Localidad l ON
          m.SUCURSAL_LOCALIDAD = l.localidad_nombre 
          OR m.SUPER_LOCALIDAD = l.localidad_nombre
    WHERE l.id_localidad IS NOT NULL
      AND p.id_provincia IS NOT NULL
      AND m.DOMICILIO_CALLE IS NOT NULL
      AND m.DOMICILIO_NUMERO IS NOT NULL
    PRINT 'Migración de migrar_domicilio terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_sucursal
AS
BEGIN
  BEGIN TRANSACTION;
  BEGIN TRY
    --crear tabla
    CREATE TABLE gd_esquema.Sucursal (
      id_sucursal INT PRIMARY KEY IDENTITY(1,1),
      id_domicilio INT NOT NULL,
      id_supermercado INT NOT NULL,
      sucursal_numero INT NOT NULL,
      
      CONSTRAINT FK_Sucursal_Domicilio FOREIGN KEY (id_domicilio) REFERENCES Domicilio(id_domicilio),
      CONSTRAINT FK_Sucursal_Supermercado FOREIGN KEY (id_supermercado) REFERENCES Supermercado(super_id)
    );
    --rellenar tablas
    INSERT INTO gd_esquema.Sucursal(
      id_domicilio,
      id_supermercado,
      sucursal_numero
    )
    SELECT
      d.id_domicilio,
      s.super_id,
      (
        SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1)
        FROM gd_esquema.Maestra m2
      ) AS Sucursal_Numero
    FROM gd_esquema.Maestra m 
      --No tenemos el id de la sucursal asi que hay que buscar combinando
      JOIN gd_esquema.Sucursal suc ON (SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1)) = suc.sucursal_numero
      -- Primero nos fijamos que la direccion coincida
      JOIN gd_esquema.Provincia p ON
        m.SUCURSAL_PROVINCIA = p.provincia_nombre 
        AND m.SUPER_PROVINCIA = p.provincia_nombre
      JOIN gd_esquema.Localidad l ON
        m.SUCURSAL_LOCALIDAD = l.localidad_nombre 
        AND m.SUPER_LOCALIDAD = l.localidad_nombre
      JOIN gd_esquema.Domicilio d ON
        l.id_localidad = d.id_localidad
        AND p.id_provincia = d.id_provincia
        AND (
              SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '')
              FROM gd_esquema.Maestra
            ) = d.domicilio_calle
        AND (
              SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') 
              FROM gd_esquema.Maestra
            ) = d.domicilio_numero
      --Por ultimo los datos para que no esten 2 super en la misma direccion (por ej un shopping)
      JOIN gd_esquema.Supermercado s ON
        m.SUPER_RAZON_SOC = s.super_razon_social
        AND m.SUPER_CUIT = s.super_cuit
        AND m.SUPER_IIBB = s.super_cuit
        AND m.SUPER_FECHA_INI_ACTIVIDAD = s.super_fecha_inicio_actividad
        AND m.SUPER_CONDICION_FISCAL = s.super_condicion_fiscal
    WHERE Sucursal_Numero IS NOT NULL
      AND d.id_domicilio IS NOT NULL
      AND s.super_id IS NOT NULL
    PRINT 'Migración de migrar_sucursal terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--TABLA CREADA
CREATE PROCEDURE gd_esquema.migrar_cliente
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Cliente(
        id_cliente INT PRIMARY KEY IDENTITY(1,1),
        cliente_dni INT NOT NULL,
        cliente_id_domicilio INT NOT NULL,
        cliente_id_contacto INT NOT NULL,
        cliente_nombre VARCHAR(100) NOT NULL,
        cliente_apellido VARCHAR(100) NOT NULL,
        cliente_fecha_registro DATE NOT NULL,
        cliente_mail VARCHAR(255) UNIQUE NOT NULL,
        cliente_fecha_nacimiento DATE NOT NULL,

        CONSTRAINT FK_Cliente_Domicilio FOREIGN KEY (cliente_id_domicilio) REFERENCES Domicilio(id_domicilio),
        CONSTRAINT FK_Cliente_Cliente_Contacto FOREIGN KEY (cliente_id_contacto) REFERENCES Cliente_Contacto(id_cliente_contacto)		
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Cliente(
        cliente_dni,
        cliente_id_domicilio,
        cliente_id_contacto,
        cliente_nombre,
        cliente_apellido,
        cliente_fecha_registro,
        cliente_mail,
        cliente_fecha_nacimiento
      )
      SELECT
        m.CLIENTE_DNI,
        d.id_domicilio, --usando CLIENTE_DOMICILIO / CLIENTE_LOCALIDAD / CLIENTE_PROVINCIA
        c.id_cliente_contacto, -- usando m.CLIENTE_TELEFONO
        m.CLIENTE_NOMBRE,
        m.CLIENTE_APELLIDO,
        m.CLIENTE_FECHA_REGISTRO,
        m.CLIENTE_MAIL,
        m.CLIENTE_FECHA_NACIMIENTO
      FROM gd_esquema.Maestra m
        JOIN gd_esquema.Cliente_Contacto c ON m.CLIENTE_TELEFONO = c.cliente_contacto_numero
        JOIN gd_esquema.Provincia p ON
          m.CLIENTE_PROVINCIA = p.provincia_nombre 
          AND m.CLIENTE_PROVINCIA = p.provincia_nombre
        JOIN gd_esquema.Localidad l ON
          m.CLIENTE_LOCALIDAD = l.localidad_nombre 
          AND m.CLIENTE_LOCALIDAD = l.localidad_nombre
        JOIN gd_esquema.Domicilio d ON
          l.id_localidad = d.id_localidad
          AND p.id_provincia = d.id_provincia
          AND (SELECT REGEXP_REPLACE(m2.CLIENTE_DOMICILIO, '[0-9]', '') FROM gd_esquema.Maestra m2) = d.domicilio_calle
          AND (SELECT REGEXP_REPLACE(m3.CLIENTE_DOMICILIO, '[^0-9]', '') FROM gd_esquema.Maestra m3) = d.domicilio_numero
      WHERE m.CLIENTE_DNI IS NOT NULL
        AND d.id_domicilio IS NOT NULL
        AND c.id_cliente_contacto IS NOT NULL
        AND m.CLIENTE_NOMBRE IS NOT NULL
        AND m.CLIENTE_APELLIDO IS NOT NULL
        AND m.CLIENTE_MAIL IS NOT NULL
      PRINT 'Migración de migrar_cliente terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_producto
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Producto (
        id_producto INT PRIMARY KEY IDENTITY(1,1),
        producto_nombre VARCHAR(100) NOT NULL,
        producto_descripcion VARCHAR(100) NOT NULL,
        producto_precio DECIMAL(10,2) NOT NULL,
        id_producto_categoria INT NOT NULL,
        id_producto_subcategoria INT NOT NULL,
        id_marca INT NOT NULL,

        CONSTRAINT FK_Producto_Producto_categoria FOREIGN KEY (id_producto_categoria) REFERENCES Producto_categoria(id_producto_categoria),
        CONSTRAINT FK_Producto_Producto_subcategoria FOREIGN KEY (id_producto_subcategoria) REFERENCES Producto_subcategoria(id_producto_subcategoria),
        CONSTRAINT FK_Producto_Producto_marca FOREIGN KEY (id_marca) REFERENCES Producto_marca(id_producto_marca)
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Producto(
        producto_nombre,
        producto_descripcion,
        producto_precio,
        id_producto_categoria,
        id_producto_subcategoria,
        id_marca
      )
      SELECT
        m.PRODUCTO_NOMBRE,
        m.PRODUCTO_DESCRIPCION,
        m.PRODUCTO_PRECIO,
        c.id_producto_categoria,
        s.id_producto_subcategoria,
        mk.id_marca
      FROM gd_esquema.Maestra m --revisar si estas uniones estan vien porque no me fio un pingo
        JOIN gd_esquema.Producto_categoria c ON m.PRODUCTO_CATEGORIA = c.producto_categoria_detalle
        JOIN gd_esquema.Producto_subcategoria s ON m.PRODUCTO_SUB_CATEGORIA = s.producto_subcategoria_detalle
        JOIN gd_esquema.Producto_marca mk ON m.PRODUCTO_MARCA = s.producto_marca_detalle
      WHERE m.PRODUCTO_NOMBRE IS NOT NULL
        AND m.PRODUCTO_DESCRIPCION IS NOT NULL
        AND m.PRODUCTO_PRECIO IS NOT NULL
        AND c.id_producto_categoria IS NOT NULL
        AND mk.id_marca IS NOT NULL
      PRINT 'Migración de migrar_producto terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------  
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_ticket
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY      
      CREATE TABLE gd_esquema.Ticket( 
        id_ticket INT PRIMARY KEY IDENTITY(1,1),
        
        id_tipo_comprobante DECIMAL NOT NULL,  
        id_sucursal INT NOT NULL,
        id_caja INT NOT NULL,
        id_empleado INT NOT NULL,

        ticket_numero INT NOT NULL,
        ticket_fecha_hora DATE NOT NULL,
        ticket_subtotal DECIMAL(10, 2) NOT NULL,
        ticket_total DECIMAL(10, 2) NOT NULL,
        ticket_monto_total_promociones_aplicadas INT NOT NULL,
        ticket_monto_total_descuentos_aplicados INT NOT NULL,

        CONSTRAINT PK_Ticket_id_ticket PRIMARY KEY (id_tipo_comprobante, id_sucursal, id_caja, id_empleado),

        CONSTRAINT FK_Ticket_id_tipo_comprobante FOREIGN KEY(id_tipo_comprobante) REFERENCES Tipo_Comprobante (id_tipo_comprobante),
        CONSTRAINT FK_Ticket_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal),
        CONSTRAINT FK_Ticket_id_caja FOREIGN KEY (id_caja) REFERENCES Caja (id_caja),
        CONSTRAINT FK_Ticket_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado (id_empleado)
      )
      INSERT INTO gd_esquema.Ticket (
        id_tipo_comprobante,  
        id_sucursal,
        id_caja,
        id_empleado,
        ticket_numero,
        ticket_fecha_hora,
        ticket_subtotal,
        ticket_total_envio,
        ticket_total,
        ticket_monto_total_descuentos_aplicados,
        ticket_monto_detalle_total
        /*ticket_monto_total_promociones_aplicadas*/
        --agregar procedimiento para calcularlo porque no esta por si solo. Aunque no se si es necesario
      )                        
      SELECT
        tc.id_tipo_comprobante, --TICKET_TIPO_COMPROBANTE
        suc.id_sucursal,
        caja.id_caja,
        emp.id_empleado,
        m.TICKET_NUMERO,
        m.TICKET_FECHA_HORA,
        m.TICKET_SUBTOTAL_PRODUCTOS,
        m.TICKET_TOTAL_ENVIO,
        m.TICKET_TOTAL_TICKET,
        (m.TICKET_TOTAL_DESCUENTO_APLICADO + m.TICKET_TOTAL_DESCUENTO_APLICADO_MP) --creo que esto es el total de descuento
        --(m. TICKET_DET_CANTIDAD + m.TICKET_DET_PRECIO + m.TICKET_DET_TOTAL) -- Esto creo que es de item_ticket
      FROM gd_esquema.Maestra m 
        JOIN gd_esquema.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
        JOIN gd_esquema.Caja caja ON m.CAJA_TIPO = c.tipo_caja_descripcion AND m.CAJA_NUMERO = c.caja_numero
        JOIN gd_esquema.Empleado emp ON m.EMPLEADO_MAIL = emp.empleado_email --como es unico podemos comparar con eso
        JOIN gd_esquema.Sucursal suc ON (SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1) FROM gd_esquema.Maestra m2) = suc.sucursal_numero
        -- Primero nos fijamos que la direccion coincida
        JOIN gd_esquema.Provincia p ON
          m.SUCURSAL_PROVINCIA = p.provincia_nombre 
          AND m.SUPER_PROVINCIA = p.provincia_nombre
        JOIN gd_esquema.Localidad l ON 
          m.SUCURSAL_LOCALIDAD = l.localidad_nombre 
          AND m.SUPER_LOCALIDAD = l.localidad_nombre
        JOIN gd_esquema.Domicilio d ON
          l.id_localidad = d.id_localidad
          AND p.id_provincia = d.id_provincia
          AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_calle
          AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_numero
        --Por ultimo los datos para que no esten 2 super en la misma direccion (por ej un shopping)
        JOIN gd_esquema.Supermercado s ON
          m.SUPER_RAZON_SOC = s.super_razon_social
          AND m.SUPER_CUIT = s.super_cuit
          AND m.SUPER_IIBB = s.super_cuit
          AND m.SUPER_FECHA_INI_ACTIVIDAD = s.super_fecha_inicio_actividad
          AND m.SUPER_CONDICION_FISCAL = s.super_condicion_fiscal
      WHERE tc.id_tipo_comprobante IS NOT NULL
        AND suc.id_sucursal IS NOT NULL
        AND caja.id_caja IS NOT NULL
        AND emp.id_empleado IS NOT NULL
        AND m.TICKET_NUMERO IS NOT NULL
        AND m.TICKET_FECHA_HORA IS NOT NULL
        AND m.TICKET_SUBTOTAL_PRODUCTOS IS NOT NULL
        AND m.TICKET_TOTAL_ENVIO IS NOT NULL
        AND m.TICKET_TOTAL_TICKET IS NOT NULL
      PRINT 'Migración de migrar_ticket terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_item_ticket 
AS
BEGIN
BEGIN TRANSACTION;
  BEGIN TRY
  CREATE TABLE gd_esquema.Item_Ticket(
    id_producto INT PRIMARY KEY,
    id_ticket INT PRIMARY KEY,
    id_tipo_comprobante INT PRIMARY KEY,
    id_sucursaL INT PRIMARY KEY,
    item_ticket_cantidad INT NOT NULL,
    item_ticket_precio INT NOT NULL,

    CONSTRAINT FK_Item_Ticket_id_producto FOREIGN KEY (id_producto) REFERENCES gd_esquema.Producto (id_producto),
    CONSTRAINT FK_Item_Ticket_id_ticket FOREIGN KEY (id_ticket) REFERENCES gd_esquema.Ticket (id_ticket),
    CONSTRAINT FK_Item_Ticket_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES gd_esquema.Tipo_Comprobante (id_tipo_comprobante),
    CONSTRAINT FK_Item_Ticket_id_sucursal FOREIGN KEY (id_sucursal)  REFERENCES gd_esquema.Sucursal (id_sucursal),
    CONSTRAINT FK_Item_Ticket_id_promocion FOREIGN KEY (id_promocion) REFERENCES gd_esquema.Promocion (id_promocion)
  )
  INSERT INTO gd_esquema.Item_Ticket(
      id_producto, 
      id_ticket,
      id_tipo_comprobante,
      id_sucursal,
      item_ticket_cantidad,
      item_ticket_precio
    )
  SELECT
    prod.id_producto,
    tick.id_ticket,
    tc.id_tipo_comprobante,
    suc.id_sucursal,
    m.TICKET_DET_CANTIDAD,
    m.TICKET_DET_PRECIO
  FROM gd_esquema.Maestra m
    JOIN gd_esquema.Producto p ON m.PRODUCTO_NOMBRE = p.producto_nombre
      JOIN gd_esquema.Producto_categoria pc ON m.PRODUCTO_CATEGORIA = pc.producto_categoria_detalle
      JOIN gd_esquema.Producto_subcategoria ps ON m.PRODUCTO_SUB_CATEGORIA = ps.producto_subcategoria_detalle
      JOIN gd_esquema.Producto_marca pm ON m.PRODUCTO_MARCA = pm.producto_marca_detalle
    JOIN gd_esquema.Ticket tick ON m.TICKET_NUMERO = tick.ticket_numero
    JOIN gd_esquema.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
    JOIN gd_esquema.Promocion p ON m.PROMO_CODIGO = p.id_promocion
    JOIN gd_esquema.Sucursal s ON (SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1) FROM gd_esquema.Maestra m2) = s.sucursal_numero
    -- Primero nos fijamos que la direccion coincida
      JOIN gd_esquema.Provincia p ON
        m.SUCURSAL_PROVINCIA = p.provincia_nombre 
        AND m.SUPER_PROVINCIA = p.provincia_nombre   
      JOIN gd_esquema.Localidad l ON
        m.SUCURSAL_LOCALIDAD = l.localidad_nombre 
        AND m.SUPER_LOCALIDAD = l.localidad_nombre
      JOIN gd_esquema.Domicilio d ON
        l.id_localidad = d.id_localidad
        AND p.id_provincia = d.id_provincia
        AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_calle
        AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_numero
      --Por ultimo los datos para que no esten 2 super en la misma direccion (por ej un shopping)
      JOIN gd_esquema.Supermercado s ON
        m.SUPER_RAZON_SOC = s.super_razon_social
        AND m.SUPER_CUIT = s.super_cuit
        AND m.SUPER_IIBB = s.super_cuit
        AND m.SUPER_FECHA_INI_ACTIVIDAD = s.super_fecha_inicio_actividad
        AND m.SUPER_CONDICION_FISCAL = s.super_condicion_fiscal
  WHERE prod.id_producto IS NOT NULL
    AND tick.id_ticket IS NOT NULL
    AND tc.id_tipo_comprobante IS NOT NULL
    AND suc.id_sucursal IS NOT NULL
    AND m.TICKET_DET_CANTIDAD IS NOT NULL
    AND m.TICKET_DET_PRECIO IS NOT NULL
  PRINT 'Migracion de migrar_item_ticket terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--tabla creada
CREATE PROCEDURE gd_esquema.migrar_medio_de_pago_aplicado
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      CREATE TABLE gd_esquema.Medio_de_pago_aplicado (
        id_medio_pago_aplicado  INT PRIMARY KEY IDENTITY(1,1),
        id_medio_pago INT NOT NULL,
        --id_cuota INT NOT NULL,
        id_cliente INT NOT NULL,
        id_descuento INT NOT NULL,
        medio_de_pago_fecha_vencimiento DATE NOT NULL,
        medio_de_pago_monto_base DECIMAL(10, 2) NOT NULL,
        medio_de_pago_monto_de_descuento_a_aplicar DECIMAL(10, 2),
        medio_de_pago_monto_base_descontado DECIMAL(10, 2),
        medio_de_pago_cuotas INT,

        CONSTRAINT FK_Medio_de_pago_aplicado_Medio_de_pago FOREIGN KEY (id_medio_pago) REFERENCES Tipo_medio_de_pago(id_medio_pago),
        --CONSTRAINT FK_Medio_de_pago_aplicado_Cuota FOREIGN KEY (id_cuota) REFERENCES Cuota(id_cuota),
        CONSTRAINT FK_Medio_de_pago_aplicado_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
        CONSTRAINT FK_Medio_de_pago_aplicado_Descuento FOREIGN KEY (id_descuento) REFERENCES Descuento(id_descuento)
      );

    INSERT INTO gd_esquema.Medio_de_pago_aplicado (
      id_medio_pago,
      id_cuota,
      id_cliente,
      id_descuento,
      medio_de_pago_fecha_vencimiento,
      medio_de_pago_monto_base,
      --medio_de_pago_monto_de_descuento_a_aplicar,
      --medio_de_pago_monto_base_descontado,
      medio_de_pago_cuotas
    )
    SELECT DISTINCT
      mp.id_medio_pago, --PAGO_MEDIO_PAGO //PAGO_TIPO_MEDIO_PAGO
      cuota.id_cuota, --PAGO_TARJETA_CUOTAS
      cl.id_cliente,
      dsc.id_descuento, --PAGO_DESCUENTO_APLICADO
      m.PAGO_FECHA,
      m.PAGO_TARJETA_FECHA_VENC,
      m.PAGO_TARJETA_NRO,
      m.PAGO_IMPORTE,
      --descuento a aplicar ?? Haria falta funcion "gd_esquema.CalcularDescuento" ??
      --descontado = (importe - descuento) Haria falta funcion "gd_esquema.DescontadoTotal" = (IMPORTE - gd_esquema.CalcularDescuento) ??
      m.PAGO_TARJETA_CUOTAS
    FROM gd_esquema.Maestra m
      JOIN gd_esquema.Tipo_medio_de_pago mp ON m.PAGO_TIPO_MEDIO_PAGO = mp.tipo_medio_pago_nombre
      JOIN gd_esquema.Cuota cuota ON m.PAGO_TARJETA_CUOTAS = cuota.cuota --revisar 
      JOIN gd_esquema.Cliente cl ON m.CLIENTE_MAIL = cl.cliente_mail --se puede porque es unico el mail para cada cliente
      JOIN gd_esquema.Descuento dsc ON m.DESCUENTO_CODIGO = dsc.descuento_codigo
    WHERE mp.id_medio_pago IS NOT NULL
      AND cuota.id_cuota IS NOT NULL
      AND cl.id_cliente IS NOT NULL
    PRINT 'Migración de migrar_medio_de_pago_aplicado terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------
--
CREATE PROCEDURE gd_esquema.migrar_regla_x_promocion
AS
BEGIN   
  BEGIN TRANSACTION;
  BEGIN TRY
    --crear tabla
    CREATE TABLE gd_esquema.Regla_X_Promocion (
      id_promocion INT,
      id_regla INT,

      CONSTRAINT PK_Regla_X_Promocion PRIMARY KEY (id_promocion, id_regla),

      CONSTRAINT FK_Regla_X_Promocion_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
      CONSTRAINT FK_Regla_X_Promocion_Regla FOREIGN KEY (id_regla) REFERENCES Regla(id_regla)
    );
    --rellenar tabla
    INSERT INTO gd_esquema.Regla_X_Promocion(
      id_promocion,
      id_regla
    )
    SELECT
      p.id_promocion,
      r.id_regla
    FROM gd_esquema.Maestra m
      JOIN gd_esquema.Promocion p ON p.promo_descripcion = m.PROMOCION_DESCRIPCION
      JOIN gd_esquema.Regla r ON r.regla_descripcion = m.REGLA_DESCRIPCION
    WHERE p.id_promocion IS NOT NULL
      AND r.id_regla IS NOT NULL
    PRINT 'Migración de migrar_regla_x_promocion terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------
--
CREATE PROCEDURE gd_esquema.migrar_ticket_x_pago
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      CREATE TABLE gd_esquema.Ticket_X_Medio_De_Pago_Aplicado(
        id_ticket INT PRIMARY KEY,
        id_medio_de_pago_aplicado INT PRIMARY KEY,
        id_tipo_comprobante INT PRIMARY KEY,
        id_sucursal INT PRIMARY KEY,

        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_medio_de_pago_aplicado FOREIGN KEY (id_medio_de_pago_aplicado) REFERENCES Medio_De_Pago_Aplicado(id_medio_de_pago_aplicado),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket (id_ticket),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES Tipo_Comprobante (id_tipo_comprobante),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal)
      );

      INSERT INTO gd_esquema.Ticket_X_Medio_De_Pago_Aplicado(
        id_ticket,
        id_medio_de_pago_aplicado,
        id_tipo_comprobante,
        id_sucursal
      ) 
      SELECT
        t.id_ticket, 
        mpa.id_medio_de_pago_aplicado, 
        tc.id_tipo_comprobante, 
        suc.id_sucursal
      FROM gd_esquema.Maestra m
        JOIN gd_esquema.Tipo_medio_de_pago mpa ON m.PAGO_MEDIO_PAGO = mpa.tipo_medio_pago_nombre
        JOIN gd_esquema.Ticket t ON m.TICKET_NUMERO = t.ticket_numero
        JOIN gd_esquema.Tipo_Comprobante tc ON m.TICKET_TIPO_COMPROBANTE = tc.tipo_comprobante_nombre
        --No tenemos el id de la sucursal asi que hay que buscar combinando
        JOIN gd_esquema.Sucursal suc ON (SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1)) =  suc.sucursal_numero
        -- Primero nos fijamos que la direccion coincida
        JOIN gd_esquema.Provincia p ON
          m.SUCURSAL_PROVINCIA = p.provincia_nombre 
          AND m.SUPER_PROVINCIA = p.provincia_nombre     
        JOIN gd_esquema.Localidad l ON
          m.SUCURSAL_LOCALIDAD = l.localidad_nombre 
          AND m.SUPER_LOCALIDAD = l.localidad_nombre
        JOIN gd_esquema.Domicilio d ON
          l.id_localidad = d.id_localidad
          AND p.id_provincia = d.id_provincia
          AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_calle
          AND (SELECT REGEXP_REPLACE(SUCURSAL_DIRECCION, '[^0-9]', '') FROM gd_esquema.Maestra) = d.domicilio_numero
        --Por ultimo los datos para que no esten 2 super en la misma direccion (por ej un shopping)
        JOIN gd_esquema.Supermercado s ON m.SUPER_RAZON_SOC = s.super_razon_social
          AND m.SUPER_CUIT = s.super_cuit
          AND m.SUPER_IIBB = s.super_cuit
          AND m.SUPER_FECHA_INI_ACTIVIDAD = s.super_fecha_inicio_actividad
          AND m.SUPER_CONDICION_FISCAL = s.super_condicion_fiscal
      WHERE mpa.id_medio_de_pago_aplicado IS NOT NULL
        AND t.id_ticket IS NOT NULL
        AND tc.id_tipo_comprobante IS NOT NULL 
        AND s.id_sucursal IS NOT NULL
      PRINT 'Migración de migrar_ticket_x_medio_de_pago_aplicado terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO 
------------------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE gd_esquema.migrar_promocion_x_item_ticket
AS
BEGIN   
  BEGIN TRANSACTION;
  BEGIN TRY
    --crear tabla
    CREATE TABLE gd_esquema.Promocion_X_Item_Ticket (--
      id_promocion INT NOT NULL,
      id_producto INT NOT NULL,
      id_ticket INT NOT NULL,

      CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_producto, id_ticket),

      CONSTRAINT FK_Promocion_X_ItemTicket_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
      CONSTRAINT FK_Promocion_X_ItemTicket_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
      CONSTRAINT FK_Promocion_X_ItemTicket_Item_Ticket FOREIGN KEY (id_ticket) REFERENCES Item_Ticket(id_ticket)      
    );
    --rellenar tabla
    INSERT INTO gd_esquema.Promocion_X_Item_Ticket(
      id_promocion,
      id_producto,
      id_ticket
    )
    SELECT
      p.id_promocion,
      (SELECT SUBSTRING_INDEX(m2.PRODUCTO_NOMBRE, ':', -1) FROM gd_esquema.Maestra m2) AS id_prod,
      t.id_ticket 
    FROM gd_esquema.Maestra m
      JOIN gd_esquema.Promocion p ON (m.PROMO_CODIGO = p.id_promocion)
      JOIN gd_esquema.Ticket t ON (m.TICKET_NUMERO = t.ticket_numero)
    WHERE p.id_promocion IS NOT NULL
      AND id_prod IS NOT NULL
      AND t.id_ticket IS NOT NULL
    PRINT 'Migración de migrar_promoxion_x_item_ticket terminada';
  COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
      ROLLBACK TRANSACTION;
      DECLARE @ErrorMessage NVARCHAR(4000);
      SET @ErrorMessage = ERROR_MESSAGE();
      RAISERROR(@ErrorMessage, 16, 1);
  END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------------------------------ 
--
CREATE PROCEDURE gd_esquema.migrar_promocion_x_producto
AS
BEGIN   
    BEGIN TRANSACTION;
    BEGIN TRY
      --crear tabla
      CREATE TABLE gd_esquema.Promocion_X_Producto (
      id_promocion INT PRIMARY KEY,
      id_producto INT PRIMARY KEY,

      CONSTRAINT FK_Promoxion_X_Producto_id_promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
      CONSTRAINT FK_Promoxion_X_Producto_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
      );
      --rellenar tabla
      INSERT INTO gd_esquema.Promocion_X_Producto(
        id_promocion,
        id_producto
      )
      SELECT
        m.PROMO_CODIGO,
        (
          SELECT SUBSTRING_INDEX(m2.PRODUCTO_NOMBRE, ':', -1) 
          FROM gd_esquema.Maestra m2
        ) AS prod_codigo
      FROM gd_esquema.Maestra m
        JOIN gd_esquema.Promocion prom ON (prod_codigo = prom.id_promocion)
        JOIN gd_esquema.Producto prod ON (m.PROMO_CODIGO = prod.id_producto)
      WHERE prod_codigo IS NOT NULL
        AND PROMO_CODIGO IS NOT NULL
      PRINT 'Migración de migrar_promocion_x_producto terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END
GO