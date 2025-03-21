-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 190.90.160.172    Database: credicel_BD_IPS_AMBIENTSALUD_SAS
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.21-MariaDB-cll-lve

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping routines for database 'credicel_BD_IPS_AMBIENTSALUD_SAS'
--
/*!50003 DROP PROCEDURE IF EXISTS `crear_relaciones_entre_tablas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`credicel_estudiantes_221024`@`%` PROCEDURE `crear_relaciones_entre_tablas`()
BEGIN
    -- Comprobar si ya existen las claves foráneas antes de crearlas
    -- para evitar errores si se ejecuta el procedimiento más de una vez
    
    -- Verificar si existe la restricción fk_orden_paciente
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_orden_paciente' 
        AND TABLE_NAME = 'ordenes_servicio'
    ) THEN
        -- Agregar relación entre ordenes_servicio y pacientes
        ALTER TABLE `ordenes_servicio` 
        ADD CONSTRAINT `fk_orden_paciente` 
        FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE;
    END IF;
    
    -- Verificar si existe la restricción fk_orden_usuario
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_orden_usuario' 
        AND TABLE_NAME = 'ordenes_servicio'
    ) THEN
        -- Agregar relación entre ordenes_servicio y usuarios
        ALTER TABLE `ordenes_servicio` 
        ADD CONSTRAINT `fk_orden_usuario` 
        FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE;
    END IF;
    
    -- Verificar si existe la restricción fk_orden_acuerdo
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_orden_acuerdo' 
        AND TABLE_NAME = 'ordenes_servicio'
    ) THEN
        -- Agregar relación entre ordenes_servicio y acuerdos_comerciales
        ALTER TABLE `ordenes_servicio` 
        ADD CONSTRAINT `fk_orden_acuerdo` 
        FOREIGN KEY (`id_acuerdo`) REFERENCES `acuerdos_comerciales` (`id_acuerdo`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE;
    END IF;
    
    -- Verificar si existe la restricción fk_detalle_orden
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_detalle_orden' 
        AND TABLE_NAME = 'detalle_orden'
    ) THEN
        -- Agregar relación entre detalle_orden y ordenes_servicio
        ALTER TABLE `detalle_orden` 
        ADD CONSTRAINT `fk_detalle_orden` 
        FOREIGN KEY (`id_orden`) REFERENCES `ordenes_servicio` (`id_orden`)
        ON DELETE CASCADE
        ON UPDATE CASCADE;
    END IF;
    
    -- Verificar si existe la restricción fk_detalle_producto
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_detalle_producto' 
        AND TABLE_NAME = 'detalle_orden'
    ) THEN
        -- Agregar relación entre detalle_orden y productos
        ALTER TABLE `detalle_orden` 
        ADD CONSTRAINT `fk_detalle_producto` 
        FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE;
    END IF;
    
    -- Verificar si existe la restricción fk_detalle_tipo_eval
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.TABLE_CONSTRAINTS 
        WHERE CONSTRAINT_NAME = 'fk_detalle_tipo_eval' 
        AND TABLE_NAME = 'detalle_orden'
    ) THEN
        -- Agregar relación entre detalle_orden y tipos_evaluacion
        ALTER TABLE `detalle_orden` 
        ADD CONSTRAINT `fk_detalle_tipo_eval` 
        FOREIGN KEY (`id_tipo_evaluacion`) REFERENCES `tipos_evaluacion` (`id_tipo_evaluacion`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE;
    END IF;
    
    SELECT 'Relaciones entre tablas creadas correctamente' AS mensaje;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `crear_tablas_normalizadas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`credicel_estudiantes_221024`@`%` PROCEDURE `crear_tablas_normalizadas`()
BEGIN
    -- Tabla para pacientes
    CREATE TABLE IF NOT EXISTS `pacientes` (
        `id_paciente` INT AUTO_INCREMENT,
        `n_identificacion` BIGINT NOT NULL,
        `nombre_paciente` VARCHAR(255) NOT NULL,
        `telefono` VARCHAR(50),
        `celular` BIGINT,
        `email` VARCHAR(100),
        `municipio_residencia` VARCHAR(100),
        `estrato` INT,
        PRIMARY KEY (`id_paciente`),
        UNIQUE INDEX `idx_identificacion` (`n_identificacion`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    -- Tabla para productos
    CREATE TABLE IF NOT EXISTS `productos` (
        `id_producto` INT AUTO_INCREMENT,
        `nombre_producto` VARCHAR(255) NOT NULL,
        `precio` DECIMAL(10,2),
        `tipo` VARCHAR(100),
        PRIMARY KEY (`id_producto`),
        INDEX `idx_nombre_producto` (`nombre_producto`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    -- Tabla para usuarios (creadores)
    CREATE TABLE IF NOT EXISTS `usuarios` (
        `id_usuario` INT AUTO_INCREMENT,
        `nombre_usuario` VARCHAR(255) NOT NULL,
        PRIMARY KEY (`id_usuario`),
        UNIQUE INDEX `idx_nombre_usuario` (`nombre_usuario`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    -- Tabla para acuerdos comerciales
    CREATE TABLE IF NOT EXISTS `acuerdos_comerciales` (
        `id_acuerdo` INT AUTO_INCREMENT,
        `nombre_acuerdo` VARCHAR(255) NOT NULL,
        PRIMARY KEY (`id_acuerdo`),
        UNIQUE INDEX `idx_nombre_acuerdo` (`nombre_acuerdo`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;
    
    -- Tabla para tipos de evaluación
    CREATE TABLE IF NOT EXISTS `tipos_evaluacion` (
        `id_tipo_evaluacion` INT AUTO_INCREMENT,
        `nombre_tipo_evaluacion` VARCHAR(255) NOT NULL,
        PRIMARY KEY (`id_tipo_evaluacion`),
        UNIQUE INDEX `idx_nombre_tipo_evaluacion` (`nombre_tipo_evaluacion`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    -- Tabla para órdenes de servicio (tabla principal) - sin relaciones
    CREATE TABLE IF NOT EXISTS `ordenes_servicio` (
        `id_orden` INT,
        `fecha_creacion` DATE,
        `id_paciente` INT NOT NULL,
        `id_usuario` INT NOT NULL,
        `observaciones` TEXT,
        `id_acuerdo` INT,
        PRIMARY KEY (`id_orden`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    -- Tabla de relación entre órdenes y productos - sin relaciones
    CREATE TABLE IF NOT EXISTS `detalle_orden` (
        `id_detalle` INT AUTO_INCREMENT,
        `id_orden` INT NOT NULL,
        `id_producto` INT NOT NULL,
        `id_tipo_evaluacion` INT,
        `precio_aplicado` DECIMAL(10,2),
        PRIMARY KEY (`id_detalle`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

    SELECT 'Tablas creadas correctamente (sin relaciones)' AS mensaje;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `migrar_datos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`credicel_estudiantes_221024`@`%` PROCEDURE `migrar_datos`()
BEGIN
    -- Variables para controlar la inserción
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_orden_servicio INT;
    DECLARE v_fecha_creacion DATE;
    DECLARE v_nombre_producto TEXT;
    DECLARE v_usuario_creacion TEXT;
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_tipo TEXT;
    DECLARE v_n_identificacion BIGINT;
    DECLARE v_nombre_paciente TEXT;
    DECLARE v_telefono TEXT;
    DECLARE v_celular BIGINT;
    DECLARE v_email TEXT;
    DECLARE v_municipio_residencia TEXT;
    DECLARE v_estrato INT;
    DECLARE v_observaciones TEXT;
    DECLARE v_tipo_evaluacion TEXT;
    DECLARE v_acuerdo_comercial TEXT;
    
    -- Variables para almacenar IDs
    DECLARE v_id_paciente INT;
    DECLARE v_id_producto INT;
    DECLARE v_id_usuario INT;
    DECLARE v_id_tipo_evaluacion INT;
    DECLARE v_id_acuerdo INT;
    
    -- Declarar cursor para recorrer la tabla original
    DECLARE cursor_original CURSOR FOR 
        SELECT id, orden_servicio, fecha_creacion, nombre_producto, usuario_creacion,
               precio, tipo, n_identificacion, nombre_paciente, telefono, celular,
               `e-mail`, municipio_residencia, estrato, observaciones, tipo_evaluacion,
               acuerdo_comercial
        FROM pacientes_por_productos;
    
    -- Continuar en caso de error
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Iniciar la transacción para asegurar la integridad de los datos
    START TRANSACTION;
    
    -- Abrir el cursor
    OPEN cursor_original;
    
    -- Bucle para procesar los registros
    read_loop: LOOP
        -- Obtener el siguiente registro
        FETCH cursor_original INTO v_id, v_orden_servicio, v_fecha_creacion, v_nombre_producto,
            v_usuario_creacion, v_precio, v_tipo, v_n_identificacion, v_nombre_paciente,
            v_telefono, v_celular, v_email, v_municipio_residencia, v_estrato,
            v_observaciones, v_tipo_evaluacion, v_acuerdo_comercial;
            
        -- Salir si no hay más registros
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Insertar o recuperar paciente
        INSERT IGNORE INTO pacientes 
            (n_identificacion, nombre_paciente, telefono, celular, email, municipio_residencia, estrato)
        VALUES 
            (v_n_identificacion, LEFT(v_nombre_paciente, 255), LEFT(v_telefono, 50), v_celular, 
             LEFT(v_email, 100), LEFT(v_municipio_residencia, 100), v_estrato);
        
        -- Obtener ID del paciente
        SELECT id_paciente INTO v_id_paciente 
        FROM pacientes 
        WHERE n_identificacion = v_n_identificacion 
        LIMIT 1;
        
        -- Insertar o recuperar producto
        INSERT IGNORE INTO productos 
            (nombre_producto, precio, tipo)
        VALUES 
            (LEFT(v_nombre_producto, 255), v_precio, LEFT(v_tipo, 100));
        
        -- Obtener ID del producto
        SELECT id_producto INTO v_id_producto 
        FROM productos 
        WHERE nombre_producto = LEFT(v_nombre_producto, 255) 
        LIMIT 1;
        
        -- Insertar o recuperar usuario
        INSERT IGNORE INTO usuarios 
            (nombre_usuario)
        VALUES 
            (LEFT(v_usuario_creacion, 255));
        
        -- Obtener ID del usuario
        SELECT id_usuario INTO v_id_usuario 
        FROM usuarios 
        WHERE nombre_usuario = LEFT(v_usuario_creacion, 255) 
        LIMIT 1;
            
        -- Insertar o recuperar tipo de evaluación si no es nulo
        IF v_tipo_evaluacion IS NOT NULL THEN
            INSERT IGNORE INTO tipos_evaluacion 
                (nombre_tipo_evaluacion)
            VALUES 
                (LEFT(v_tipo_evaluacion, 255));
            
            -- Obtener ID del tipo de evaluación
            SELECT id_tipo_evaluacion INTO v_id_tipo_evaluacion 
            FROM tipos_evaluacion 
            WHERE nombre_tipo_evaluacion = LEFT(v_tipo_evaluacion, 255) 
            LIMIT 1;
        ELSE
            SET v_id_tipo_evaluacion = NULL;
        END IF;
        
        -- Insertar o recuperar acuerdo comercial si no es nulo
        IF v_acuerdo_comercial IS NOT NULL THEN
            INSERT IGNORE INTO acuerdos_comerciales 
                (nombre_acuerdo)
            VALUES 
                (LEFT(v_acuerdo_comercial, 255));
            
            -- Obtener ID del acuerdo comercial
            SELECT id_acuerdo INTO v_id_acuerdo 
            FROM acuerdos_comerciales 
            WHERE nombre_acuerdo = LEFT(v_acuerdo_comercial, 255) 
            LIMIT 1;
        ELSE
            SET v_id_acuerdo = NULL;
        END IF;
        
        -- Insertar orden de servicio
        INSERT IGNORE INTO ordenes_servicio 
            (id_orden, fecha_creacion, id_paciente, id_usuario, observaciones, id_acuerdo)
        VALUES 
            (v_orden_servicio, v_fecha_creacion, v_id_paciente, v_id_usuario, v_observaciones, v_id_acuerdo);
        
        -- Insertar detalle de orden
        INSERT INTO detalle_orden 
            (id_orden, id_producto, id_tipo_evaluacion, precio_aplicado)
        VALUES 
            (v_orden_servicio, v_id_producto, v_id_tipo_evaluacion, v_precio);
    
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cursor_original;
    
    -- Confirmar la transacción
    COMMIT;
    
    SELECT 'Migración de datos completada correctamente' AS mensaje;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-20 21:44:56
