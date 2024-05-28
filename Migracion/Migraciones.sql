  /*------------------------------------PROCEDIMIENTOS PARA MIGRAR TABLAS------------------------------------*/
  /*------------------------------------TABLAS SIN CLAVE FORANEA------------------------------------*/
  CREATE PROCEDURE dbo.migrar_producto_categoria
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Producto_categoria (
          id_producto_categoria INT PRIMARY KEY IDENTITY(1,1),
          producto_categoria_detalle VARCHAR(100) NOT NULL,

          CONSTRAINT UQ_Producto_categoria_detalle UNIQUE (producto_categoria_detalle)
        );
        --rellenar tabla
        INSERT INTO dbo.Producto_categoria(producto_categoria_detalle)
          SELECT DISTINCT PRODUCTO_CATEGORIA
          FROM dbo.Maestra
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
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_producto_subcategoria
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
         CREATE TABLE dbo.Producto_subcategoria (
            id_producto_subcategoria INT PRIMARY KEY IDENTITY(1,1),
            producto_subcategoria_detalle VARCHAR(100),

            CONSTRAINT UQ_Producto_subcategoria_detalle UNIQUE (producto_subcategoria_detalle)
          );
        --rellenar tabla
        INSERT INTO dbo.Producto_subcategoria(producto_subcategoria_detalle)
          SELECT DISTINCT PRODUCTO_SUB_CATEGORIA
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_producto_marca
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Producto_marca (
          id_producto_marca INT PRIMARY KEY IDENTITY(1,1),
          producto_marca_detalle VARCHAR(100),

          CONSTRAINT UQ_Producto_marca_detalle UNIQUE (producto_marca_detalle)
         );
        --rellenar tabla
        INSERT INTO dbo.Producto_marca(producto_marca_detalle)
          SELECT DISTINCT PRODUCTO_MARCA
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_cliente_contacto
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
         CREATE TABLE dbo.Cliente_Contacto (
          id_cliente_contacto INT PRIMARY KEY IDENTITY(1,1),
          cliente_contacto_numero VARCHAR(20),

          CONSTRAINT UQ_cliente_contacto_numero UNIQUE (cliente_contacto_numero)
        );
        --rellenar tabla
        INSERT INTO dbo.Cliente_Contacto(cliente_contacto_numero)
          SELECT DISTINCT CLIENTE_TELEFONO
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_tipo_medio_de_pago
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Tipo_medio_de_pago (
          id_tipo_medio_pago INT PRIMARY KEY IDENTITY(1,1),
          tipo_medio_pago_nombre VARCHAR(255) NOT NULL,

          CONSTRAINT UQ_tipo_medio_pago_nombre UNIQUE (tipo_medio_pago_nombre)
        );
        --rellenar tabla
        INSERT INTO dbo.Tipo_medio_de_pago(tipo_medio_pago_nombre)
          SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_descuento
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Descuento (
          id_descuento INT PRIMARY KEY IDENTITY(1,1),
          descuento_descripcion VARCHAR(255) NOT NULL,
          descuento_fecha_inicio DATE NOT NULL,
          descuento_fecha_fin DATE NOT NULL,
          descuento_valor_porcentual_a_aplicar DECIMAL(5, 2) NOT NULL,
          descuento_tope DECIMAL(10, 2) NOT NULL,

          CONSTRAINT CHK_Descuento_fechas CHECK (fecha_fin >= fecha_inicio),
          CONSTRAINT CHK_Descuento_valor_porcentual CHECK
            (descuento_valor_porcentual_a_aplicar >= 0 AND descuento_valor_porcentual_a_aplicar <= 99.99),
          CONSTRAINT CHK_Descuento_tope CHECK (descuento_tope >= 0 AND descuento_tope <= 99999999.99) 
            --No se si es tanto el descuento, chequear
        );
        --rellenar tabla
        INSERT INTO dbo.Descuento(
          id_descuento,
          descuento_descripcion,
          descuento_fecha_inicio,
          descuento_fecha_fin,
          descuento_valor_porcentual_a_aplicar,
          descuento_tope
        )
          SELECT(
            DESCUENTO_CODIGO
            DESCUENTO_DESCRIPCION
            DESCUENTO_FECHA_INICIO
            DESCUENTO_FECHA_FIN
            DESCUENTO_PORCENTAJE_DESC
            DESCUENTO_TOPE
          )
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_regla
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Regla (
          id_regla INT PRIMARY KEY IDENTITY(1,1),
          regla_cantidad_aplicable INT NOT NULL,
          regla_descripcion VARCHAR(255) NOT NULL,
          regla_cantidad_aplicable_descuento INT NOT NULL,
          regla_cantidad_maxima INT NOT NULL,
          regla_misma_marca BOOLEAN NOT NULL,
          regla_mismo_producto BOOLEAN NOT NULL,
          regla_descuento_aplicable_prod DECIMAL(3, 2) NOT NULL,

          CONSTRAINT CHK_Regla_descuento_aplicable_prod CHECK (regla_descuento_aplicable_prod >= 0 AND regla_descuento_aplicable_prod <= 0.99)
        );
        --rellenar tabla
        INSERT INTO dbo.Regla(
          regla_cantidad_aplicable,
          regla_descripcion,
          regla_cantidad_aplicable_descuento,
          regla_cantidad_maxima,
          regla_misma_marca,
          regla_mismo_producto,
          regla_descuento_aplicable_prod
        )
          SELECT(
            REGLA_CANT_APLICABLE_REGLA,
            REGLA_DESCRIPCION,
            REGLA_CANT_APLICA_DESCUENTO,
            REGLA_CANT_MAX_PROD,
            REGLA_APLICA_MISMA_MARCA,
            REGLA_APLICA_MISMO_PROD,
            REGLA_DESCUENTO_APLICABLE_PROD
          )
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_supermercado
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
       CREATE TABLE dbo.Supermercado (
          super_id INT PRIMARY KEY IDENTITY(1,1),
          super_nombre VARCHAR(255) UNIQUE NOT NULL,
          super_razon_social VARCHAR(255) NOT NULL,
          super_cuit VARCHAR(20) NOT NULL,
          super_iibb VARCHAR(20) NOT NULL,
          super_fecha_inicio_actividad DATE NOT NULL,
          super_condicion_fiscal VARCHAR(50) NOT NULL
        );
        --rellenar tabla
        INSERT INTO dbo.Supermercado(
          super_nombre,
          super_razon_social,
          super_cuit,
          super_iibb,
          super_fecha_inicio_actividad,
          super_condicion_fiscal
        )
          SELECT(
            SUPER_NOMBRE,
            SUPER_RAZON_SOC,
            SUPER_CUIT,
            SUPER_IIBB,
            SUPER_FECHA_INI_ACTIVIDAD,
            SUPER_CONDICION_FISCAL
            /*Esto no lo guardamos aca, sino en la tabla dbo.Domicilio*/
            --SUPER_DOMICILIO
            /*Estos los guardamos cada uno en sus respectivas tablas*/
            --SUPER_LOCALIDAD
            --SUPER_PROVINCIA
          )
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_tipo_caja
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Tipo_Caja(
          id_tipo_caja INT PRIMARY KEY IDENTITY(1,1),
          tipo_caja_descripcion VARCHAR(50),

          CONSTRAINT UQ_tipo_caja_descripcion UNIQUE (tipo_caja_descripcion)
        );
        --rellenar tabla
        INSERT INTO dbo.Tipo_Caja(tipo_caja_descripcion)
          SELECT DISTINCT(CAJA_TIPO)
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_tipo_comprobante
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Tipo_Comprobante(
          id_tipo_comprobante INT PRIMARY KEY IDENTITY(1,1),
          tipo_comprobante_nombre VARCHAR (1), --caracter
        );
        --rellenar tabla
        INSERT INTO dbo.Tipo_Comprobante(tipo_comprobante_nombre)
          SELECT DISTINCT(TICKET_TIPO_COMPROBANTE)
          FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_provincia
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
         CREATE TABLE dbo.Provincia(
          id_provincia INT PRIMARY KEY IDENTITY(1,1),
          provincia_nombre VARCHAR(100),

          CONSTRAINT UQ_provincia_nombre UNIQUE (provincia_nombre)
        );

        --rellenar tabla
        /*Esta en dos campos distintos asi que los sacamos de las dos tablas*/
        INSERT INTO dbo.Provincia(provincia_nombre)
          SELECT DISTINCT SUCURSAL_PROVINCIA
          FROM dbo.Maestra
          WHERE SUCURSAL_PROVINCIA IS NOT NULL;

        INSERT INTO dbo.Provincia(provincia_nombre)
          SELECT DISTINCT SUPER_PROVINCIA
          FROM dbo.Maestra
          WHERE SUPER_PROVINCIA IS NOT NULL
            AND SUPER_PROVINCIA NOT IN (SELECT provincia_nombre FROM dbo.Provincia);
        PRINT 'Migración de migrar_provincia terminada';
      COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          DECLARE @ErrorMessage NVARCHAR(4000);
          SET @ErrorMessage = ERROR_MESSAGE();
          RAISERROR(@ErrorMessage, 16, 1);
      END CATCH
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_localidad
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
          CREATE TABLE dbo.Localidad(
            id_localidad INT PRIMARY KEY IDENTITY(1,1),
            localidad_nombre VARCHAR(100),

            CONSTRAINT UQ_localidad_nombre UNIQUE (localidad_nombre)
          );

        --rellenar tabla
        /*Esta en dos campos distintos asi que los sacamos de las dos tablas*/
        INSERT INTO dbo.Localidad(localidad_nombre)
          SELECT DISTINCT SUCURSAL_LOCALIDAD
          FROM dbo.Maestra
          WHERE SUCURSAL_LOCALIDAD IS NOT NULL;

        INSERT INTO dbo.Localidad(localidad_nombre)
          SELECT DISTINCT SUPER_LOCALIDAD
          FROM dbo.Maestra
          WHERE SUPER_LOCALIDAD IS NOT NULL
            AND SUPER_LOCALIDAD NOT IN (SELECT localidad_nombre FROM dbo.Localidad);
        PRINT 'Migración de migrar_localidad terminada';
      COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          DECLARE @ErrorMessage NVARCHAR(4000);
          SET @ErrorMessage = ERROR_MESSAGE();
          RAISERROR(@ErrorMessage, 16, 1);
      END CATCH
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_promocion
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Promocion (
          id_promocion INT PRIMARY KEY IDENTITY(1,1),
          promo_descripcion VARCHAR(255) NOT NULL,
          promo_fecha_inicio DATE NOT NULL,
          promo_fecha_fin DATE NOT NULL,
        );
        --rellenar tabla
        INSERT INTO dbo.Promocion(
          id_promocion,
          promo_descripcion,
          promo_fecha_inicio,
          promo_fecha_fin,
          promo_valor_descuento,
        )
        SELECT(
          PROMO_CODIGO,
          PROMOCION_DESCRIPCION,
          PROMOCION_FECHA_INICIO,
          PROMOCION_FECHA_FIN,
          PROMO_APLICADA_DESCUENTO
        )
        FROM dbo.Maestra
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
  END;
  ------------------------------------------------------------------------------------------------------------------------------------------------
  /*------------------------------------TABLAS CON CLAVE FORANEA------------------------------------*/
  --De las que tienen menos claves a las que tienen mas claves (facil a dificil)    
  --Ver "Estrategia" de tp de nacho que esta en wpp y en el ds (sino preguntar en wp y se vuelve a pasar el documento)
  --Eto es complicado, lean muy bien el doc asi entienden la pucha que los tiro  
  ------------------------------------------------------------------------------------------------------------------------------------------------    
  CREATE PROCEDURE dbo.migrar_Empleado
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Empleado(
          id_empleado INT PRIMARY KEY IDENTITY(1,1),
          id_sucursal INT, --FK
          empleado_nombre VARCHAR(15) NOT NULL,
          empleado_apellido VARCHAR(30) NOT NULL,
          empleado_dni INT NOT NULL,
          empleado_fecha_registro DATE NOT NULL,
          empleado_fecha_nacimiento DATE NOT NULL,
          empleado_email VARCHAR (30) UNIQUE NOT NULL,

          CONSTRAINT FK_Empleado_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES dbo.Sucursal (id_sucursal) 
        );
        --rellenar tabla
        INSERT INTO dbo.Empleado(
          empleado_nombre,
          empleado_apellido,
          empleado_dni,
          empleado_fecha_registro,
          empleado_fecha_nacimiento,
          empleado_email,
          id_sucursal        
        )
        SELECT(
          m.EMPLEADO_NOMBRE
          m.EMPLEADO_APELLIDO
          m.EMPLEADO_DNI
          m.EMPLEADO_FECHA_REGISTRO
          m.EMPLEADO_TELEFONO
          m.EMPLEADO_MAIL
          m.EMPLEADO_FECHA_NACIMIENTO
          s.id_sucural -- la id la generamos en la tabla Sucursal
        )
        FROM dbo.Maestra m
          JOIN dbo.Sucursal s 
          ON (
            s.id_sucursal = (SELECT SUBSTRING_INDEX(m2.SUCURSAL_NOMBRE, ':', -1) FROM dbo.Maestra m2) 
          	--AND ver de que mas campos se tienen que agregar para que sea completo 
          ) 
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
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------------
  CREATE PROCEDURE dbo.migrar_caja
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Caja(
        id_caja INT PRIMARY KEY IDENTITY(1,1), -- el dni de la caja
        caja_numero INT, 	-- numero (independientemente del tipo)
        id_tipo_caja INT, -- dni del tipo de caja

        CONSTRAINT FK_Caja_id_caja_tipo FOREIGN KEY (id_tipo_caja) REFENRENCES Tipo_Caja (id_tipo_caja)
        );
        --rellenar tabla
       INSERT INTO dbo.Caja(
          caja_numero,
          id_tipo_caja
       );
       SELECT(
          m.CAJA_NUMERO, 
          c.id_tipo_caja
       )
       FROM dbo.Maestra m
        JOIN dbo.Tipo_Caja c ON ( m.CAJA_TIPO = c.tipo_caja_descripcion)
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
  END;

  ------------------------------------------------------------------------------------------------------------------------------------------------ 
  CREATE PROCEDURE dbo.migrar_promocion_x_producto
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla
        CREATE TABLE dbo.Promocion_X_Producto (
        id_promocion INT,
        id_producto INT,

        CONSTRAINT PK_Promoxion_X_Producto PRIMARY KEY (id_promocion, id_producto),

        CONSTRAINT FK_Promoxion_X_Producto_id_promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
        CONSTRAINT FK_Promoxion_X_Producto_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
        );
        --rellenar tabla
        INSERT INTO (
          id_promocion,
        	id_producto)
        SELECT(
          (SELECT SUBSTRING_INDEX(m2.PRODUCTO_NOMBRE, ':', -1) FROM dbo.Maestra m2) AS prod_nombre,
          m.PROMO_CODIGO
        )
        FROM dbo.Maestra m
          JOIN dbo.Promocion p1 ON (prod_nombre = p1.id_promocion)
          JOIN dbo.Producto p2 ON (PROMO_CODIGO = p2.id_producto)
        WHERE prod_nombre IS NOT NULL
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
  END;
------------------------------------------------------------------------------------------------------------------------------------------------
       CREATE TABLE Envio (
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
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Regla_X_Promocion (
        id_promocion INT,
        id_regla INT,

        CONSTRAINT PK_Regla_X_Promocion PRIMARY KEY (id_promocion, id_regla),

        CONSTRAINT FK_Regla_X_Promocion_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
        CONSTRAINT FK_Regla_X_Promocion_Regla FOREIGN KEY (id_regla) REFERENCES Regla(id_regla)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Domicilio (
        id_domicilio INT PRIMARY KEY IDENTITY(1,1),
        id_localidad INT,
        id_provincia INT,
        domicilio_calle VARCHAR(255),
        domicilio_numero INT,
        domicilio_detalle_piso VARCHAR(100),

        CONSTRAINT FK_Domicilio_Localidad FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad),
        CONSTRAINT FK_Domicilio_Provincia FOREIGN KEY (id_provincia) REFERENCES Provincia(id_provincia)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------

      CREATE TABLE Sucursal (
        id_sucursal INT PRIMARY KEY IDENTITY(1,1),
        id_domicilio INT,
        id_supermercado INT,
        sucursal_nombre VARCHAR(255) UNIQUE NOT NULL,

        CONSTRAINT FK_Sucursal_Domicilio FOREIGN KEY (id_domicilio) REFERENCES Domicilio(id_domicilio),
        CONSTRAINT FK_Sucursal_Supermercado FOREIGN KEY (id_supermercado) REFERENCES Supermercado(super_id)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Cliente (
        id_cliente INT PRIMARY KEY IDENTITY(1,1),
        dni INT,
        id_domicilio INT,
        id_cliente_contacto INT,
        cliente_nombre VARCHAR(100),
        cliente_apellido VARCHAR(100),
        cliente_fecha_registro DATE,
        cliente_mail VARCHAR(255) UNIQUE,
        cliente_fecha_nacimiento DATE,

        CONSTRAINT FK_Cliente_Domicilio FOREIGN KEY (id_domicilio) REFERENCES Domicilio(id_domicilio),
        CONSTRAINT FK_Cliente_Cliente_Contacto FOREIGN KEY (id_cliente_contacto) REFERENCES Cliente_Contacto(id_cliente_contacto)		
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Medio_de_pago (
        id_medio_pago INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_medio_pago INT,
        id_entidad_bancaria INT,
        medio_de_pago_nombre VARCHAR(255),

        CONSTRAINT FK_Medio_de_pago_Tipo_medio_de_pago FOREIGN KEY (id_tipo_medio_pago) REFERENCES Tipo_medio_de_pago(id_tipo_medio_pago),
        CONSTRAINT FK_Medio_de_pago_Entidad_bancaria FOREIGN KEY (id_entidad_bancaria) REFERENCES Medio_de_pago_X_Entidad_bancaria(id_entidad_bancaria)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Medio_de_pago_x_entidad_bancaria (
        id_entidad_bancaria INT,
        id_medio_pago INT,

       CONSTRAINT PK_Medio_de_pago_x_entidad_bancaria PRIMARY KEY (id_entidad_bancaria, id_medio_pago),

        CONSTRAINT FK_Medio_de_pago_x_entidad_bancaria_Entidad_Bancaria FOREIGN KEY (id_entidad_bancaria) REFERENCES Entidad_Bancaria(id_entidad_bancaria),
        CONSTRAINT FK_Medio_de_pago_x_entidad_bancaria_Tipo_medio_de_pago FOREIGN KEY (id_medio_pago) REFERENCES Tipo_medio_de_pago(id_tipo_medio_pago)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Producto (
        id_producto INT PRIMARY KEY IDENTITY(1,1),
        producto_nombre VARCHAR(100) NOT NULL,
        producto_descripcion VARCHAR(100),
        producto_precio DECIMAL(10,2),
        id_producto_categoria INT,
        id_producto_subcategoria INT,
        id_marca INT,

        CONSTRAINT FK_Producto_Producto_categoria FOREIGN KEY (id_producto_categoria) REFERENCES Producto_categoria(id_producto_categoria),
        CONSTRAINT FK_Producto_Producto_subcategoria FOREIGN KEY (id_producto_subcategoria) REFERENCES Producto_subcategoria(id_producto_subcategoria),
        CONSTRAINT FK_Producto_Producto_marca FOREIGN KEY (id_marca) REFERENCES Producto_marca(id_producto_marca)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Promocion_X_ItemTicket (
        id_promocion INT,
        id_producto INT,
        id_ticket INT,

        CONSTRAINT PK_Promocion_X_ItemTicket PRIMARY KEY (id_promocion, id_producto, id_ticket),

        CONSTRAINT FK_Promocion_X_ItemTicket_Promocion FOREIGN KEY (id_promocion) REFERENCES Promocion(id_promocion),
        CONSTRAINT FK_Promocion_X_ItemTicket_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
        CONSTRAINT FK_Promocion_X_ItemTicket_Item_Ticket FOREIGN KEY (id_ticket) REFERENCES Item_Ticket(id_ticket)      
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------
      CREATE TABLE Ticket_X_Medio_De_Pago_Aplicado(
        id_medio_de_pago_aplicado INT,
        id_ticket INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_comprobante INT,
        id_sucursar INT,

        CONSTRAINT PK_Ticket_X_Medio_De_Pago_Aplicado PRIMARY KEY (id_medio_de_pago_aplicado, id_tipo_comprobante, id_sucursal)

        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_medio_de_pago_aplicado FOREIGN KEY (id_medio_de_pago_aplicado) REFERENCES Medio_De_Pago_Aplicado(id_medio_de_pago_aplicado),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_ticket FOREIGN KEY (id_ticket) REFERENCES Ticket (id_ticket),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES Tipo_Comprobante (id_tipo_comprobante),
        CONSTRAINT FK_Ticket_X_Medio_De_Pago_Aplicado_id_sucursal FOREIGN KEY (id_sucursal) REFERENCES Sucursal (id_sucursal)
      );
  ------------------------------------------------------------------------------------------------------------------------------------------------

      CREATE TABLE Medio_de_pago_aplicado (
        id_medio_pago_aplicado  INT PRIMARY KEY IDENTITY(1,1),
        id_medio_pago INT,
        id_cuota INT,
        id_cliente INT,
        id_descuento INT,
        medio_de_pago_numero VARCHAR(50),
        medio_de_pago_fecha_vencimiento DATE,
        medio_de_pago_monto_base DECIMAL(10, 2),
        medio_de_pago_monto_de_descuento_a_aplicar DECIMAL(10, 2),
        medio_de_pago_monto_base_descontado DECIMAL(10, 2),

        CONSTRAINT FK_Medio_de_pago_aplicado_Medio_de_pago FOREIGN KEY (id_medio_pago) REFERENCES Medio_de_pago(id_medio_pago),
        CONSTRAINT FK_Medio_de_pago_aplicado_Cuota FOREIGN KEY (id_cuota) REFERENCES Cuota(id_cuota),
        CONSTRAINT FK_Medio_de_pago_aplicado_Cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
        CONSTRAINT FK_Medio_de_pago_aplicado_Descuento FOREIGN KEY (id_descuento) REFERENCES Descuento(id_descuento)
      );

  ------------------------------------------------------------------------------------------------------------------------------------------------

      CREATE TABLE dbo.Item_Ticket(
        id_producto INT,
        id_ticket INT,
        id_tipo_comprobante INT,
        id_sucursar INT,
        item_ticket_cantidad INT,
        item_ticket_precio INT,

        CONSTRAINT PK_Item_Ticket PRIMARY KEY (id_producto, id_ticket, id_tipo_comprobante, id_sucursal),

        CONSTRAINT FK_Item_Ticket_id_producto FOREIGN KEY (id_producto) REFERENCES dbo.Producto (id_producto),
        CONSTRAINT FK_Item_Ticket_id_ticket FOREIGN KEY (id_ticket) REFERENCES dbo.Ticket (id_ticket),
        CONSTRAINT FK_Item_Ticket_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES dbo.Ticket (id_tipo_comprobante),
        CONSTRAINT FK_Item_Ticket_id_sucursal FOREIGN KEY (id_sucursal)  REFERENCES dbo.Sucursal (id_sucursal),
        CONSTRAINT FK_Item_Ticket_id_promocion FOREIGN KEY (id_promocion) REFERENCES dbo.Promocion (id_promocion)
      )
  ------------------------------------------------------------------------------------------------------------------------------------------------
  /*
  CREATE PROCEDURE dbo.migrar_
  AS
  BEGIN   
      BEGIN TRANSACTION;
      BEGIN TRY
        --crear tabla

        --rellenar tabla

        PRINT 'Migración de _ terminada';
      COMMIT TRANSACTION;
      END TRY
      BEGIN CATCH
          ROLLBACK TRANSACTION;
          DECLARE @ErrorMessage NVARCHAR(4000);
          SET @ErrorMessage = ERROR_MESSAGE();
          RAISERROR(@ErrorMessage, 16, 1);
      END CATCH
  END;
  */





