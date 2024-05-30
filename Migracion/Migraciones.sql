CREATE PROCEDURE dbo.migrar_item_ticket 
AS
BEGIN
BEGIN TRANSACTION;
    BEGIN TRY
    CREATE TABLE dbo.Item_Ticket(
      id_producto INT NOT NULL,
      id_ticket INT NOT NULL,
      id_tipo_comprobante INT NOT NULL,
      id_sucursaL INT NOT NULL,
      item_ticket_cantidad INT NOT NULL,
      item_ticket_precio INT NOT NULL,

      CONSTRAINT PK_Item_Ticket PRIMARY KEY (id_producto, id_ticket, id_tipo_comprobante, id_sucursal),

      CONSTRAINT FK_Item_Ticket_id_producto FOREIGN KEY (id_producto) REFERENCES dbo.Producto (id_producto),
      CONSTRAINT FK_Item_Ticket_id_ticket FOREIGN KEY (id_ticket) REFERENCES dbo.Ticket (id_ticket),
      CONSTRAINT FK_Item_Ticket_id_tipo_comprobante FOREIGN KEY (id_tipo_comprobante) REFERENCES dbo.Tipo_Comprobante (id_tipo_comprobante),
      CONSTRAINT FK_Item_Ticket_id_sucursal FOREIGN KEY (id_sucursal)  REFERENCES dbo.Sucursal (id_sucursal),
      CONSTRAINT FK_Item_Ticket_id_promocion FOREIGN KEY (id_promocion) REFERENCES dbo.Promocion (id_promocion)
    )
    INSERT INTO dbo.Item_Ticket(
        id_producto,  --
        id_ticket,  --
        id_tipo_comprobante,
        id_sucursal,
        item_ticket_cantidad,
        item_ticket_precio
      )
    SELECT(
      p.Producto,
      t.Ticket,
      t.Tipo_Comprobante,
      s.Sucursal,
      t.Item_ticket,
      t.Item_ticket	

    )
    FROM dbo.Maestra      JOIN dbo.Producto p ON (m.PRODUCTO_NOMBRE = p.Producto)
      JOIN dbo.Ticket t ON (m.TICKET_NUMERO = t.Ticket)
      JOIN dbo.Tipo_Comprobante t ON (m.TICKET_TIPO_COMPROBANTE = t.Tipo_Comprobante)
      JOIN dbo.Sucursal s ON (m.SUCURSAL_NOMBRE = s.Sucursal)
      JOIN dbo.Promocion p ON (m.PROMO_CODIGO = p.Promocion)
    WHERE m.PRODUCTO_NOMBRE IS NOT NULL
      AND m.TICKET_NUMERO IS NOT NULL
      AND m.TICKET_TIPO_COMPROBANTE IS NOT NULL
      AND m.SUCURSAL_NOMBRE IS NOT NULL
      AND m.PROMO_CODIGO IS NOT NULL
    PRINT 'MigraciÃ³n de migrar_item_ticket terminada';
    COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(4000);
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
