CREATE TABLE IF NOT EXISTS 'Roles'(
  'rol_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre' VARCHAR(45) NULL UNIQUE DEFAULT '',
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'descripcion' TEXT NULL);


CREATE TABLE IF NOT EXISTS 'paises' (
  'pais_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre' VARCHAR(45) NULL UNIQUE,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY ('pais_id'));


CREATE TABLE IF NOT EXISTS 'Autores'(
  'autor_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre_completo' VARCHAR(45) NULL UNIQUE,
  'descripcion' TEXT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'pais_id' INT NOT NULL,
  INDEX 'FKAutoresPaises_idx' ('pais_id' ASC),
  CONSTRAINT 'FKAutoresPaises'
    FOREIGN KEY ('pais_id')
    REFERENCES 'Paises' ('pais_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS 'Editoriales'(
  'editorial_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre' VARCHAR(45) NULL UNIQUE,
  'descripcion' VARCHAR(45) NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE());


CREATE TABLE IF NOT EXISTS 'InventarioLibros'(
  'inventario_libro_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'titulo' VARCHAR(100) NOT NULL DEFAULT '',
  'paginas' INT NOT NULL DEFAULT '0',
  'descripcion' TEXT NOT NULL,
  'editorial_id' INT NOT NULL,
  'autor_id' INT NOT NULL,
  'categoria_id' INT NOT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'imagen' VARCHAR(100) NULL,
  INDEX 'FKLibrosAutores_idx' ('autor_id' ASC),
  INDEX 'FKLibrosEditoriales_idx' ('editorial_id' ASC),
  INDEX 'FKLibrosCategorias_idx' ('categoria_id' ASC))
DEFAULT CHARACTER SET = latin1


CREATE TABLE IF NOT EXISTS 'Libros'(
  'libro_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'isbn' VARCHAR(100) NULL UNIQUE,
  'ubicacion' VARCHAR(45) NULL UNIQUE,
  'inventario_libro_id' INT NOT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  INDEX 'FKLibrosInventarioLibros_idx' ('inventario_libro_id' ASC),
  CONSTRAINT 'FKLibrosInventarioLibros'
    FOREIGN KEY ('inventario_libro_id')
    REFERENCES 'InventarioLibros' ('inventario_libro_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE IF NOT EXISTS 'Usuarios'(
  'usuario_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'user' TEXT NOT NULL UNIQUE,
  'password' VARCHAR(15) NOT NULL DEFAULT '',
  'nombres' VARCHAR(50) NOT NULL DEFAULT '',
  'apellidos' VARCHAR(45) NULL,
  'telefono' VARCHAR(8) NOT NULL DEFAULT '',
  'email' VARCHAR(60) NOT NULL DEFAULT '',
  'direccion' TEXT NOT NULL,
  'fecha_nacimiento' DATETIME NULL,
  'rol_id' INT NOT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'is_deleted' BIT NULL DEFAULT 0,
  'imagen' TEXT NULL,
  'is_blocked' BIT NULL DEFAULT 0,
  'ciudad_id' INT NOT NULL,
  INDEX 'FKUsuariosRoles_idx' ('rol_id' ASC),
  INDEX 'FKUsuariosCiudades_idx' ('ciudad_id' ASC))
DEFAULT CHARACTER SET = latin1



CREATE TABLE IF NOT EXISTS 'Ciudades'(
  'ciudad_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre' VARCHAR(45) NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  PRIMARY KEY ('ciudad_id'));



CREATE TABLE IF NOT EXISTS 'Estudiantes'(
  'estudiante_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'carnet' VARCHAR(45) NULL,
  'password' VARCHAR(45) NULL,
  'nombres' VARCHAR(45) NULL,
  'apellidos' VARCHAR(45) NULL,
  'email' VARCHAR(50) NULL UNIQUE,
  'fecha_nacimiento' DATETIME NULL,
  'genero' VARCHAR(4) NULL DEFAULT '',
  'imagen' VARCHAR(100) NULL,
  'telefono' VARCHAR(45) NULL,
  'celular' VARCHAR(45) NULL,
  'direccion' TEXT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'id_deleted' BIT NULL DEFAULT 0,
  'is_blocked' BIT NULL DEAFULT 0,
  'ciudad_id' VARCHAR(45) NOT NULL
  INDEX 'FKEstudiantesCiudades_idx' ('ciudad_id' ASC),
  CONSTRAINT 'FKEstudiantesCiudades'
    FOREIGN KEY ('ciudad_id')
    REFERENCES 'Ciudades' ('ciudad_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS 'Notificaciones'(
  'notificacion_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'mensaje' TEXT NULL,
  'contador' INT NULL DEAFULT 0,
  'notificador_id' INT NOT NULL,
  'notificador_tipo' VARCHAR(45) NULL,
  'notificado_id' INT NOT NULL,
  'notificado_tipo' VARCHAR(45) NULL,
  'leido' BIT NULL DEFAULT 0,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  INDEX 'FKNotificacionesEstudiantes_idx' ('notificador_id' ASC),
  INDEX 'FKNotificacionesUsuarios_idx' ('notificado_id' ASC),
  CONSTRAINT 'FKNotificacionesEstudiantes'
    FOREIGN KEY ('notificador_id')
    REFERENCES 'Estudiantes' ('estudiante_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'FKNotificacionesUsuarios'
    FOREIGN KEY ('notificado_id')
    REFERENCES 'Usuarios' ('usuario_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS 'Categorias'(
  'categoria_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'nombre' VARCHAR(50) NOT NULL UNIQUE DEFAULT '',
  'descripcion' TEXT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
DEFAULT CHARACTER SET = latin1



CREATE TABLE IF NOT EXISTS 'Comprobantes'(
  'comprobante_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'carnet' VARCHAR(45) NOT NULL UNIQUE,
  'prestamo_id' INT NOT NULL
  INDEX 'FKComprobantesEstudiantes_idx' ('carnet' ASC),
  INDEX 'FKComprobantesPrestamos_idx' ('prestamo_id' ASC))
DEFAULT CHARACTER SET = latin1



CREATE TABLE IF NOT EXISTS 'ComprobanteDetalles'(
  'comprobante_detalle_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'cantidad' VARCHAR(45) NULL,
  'comprobante_id' INT NOT NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'inventario_libro_id' INT NOT NULL
  INDEX 'FKComprobanteDetallesComprobantes_idx' ('comprobante_id' ASC),
  INDEX 'FKComprobanteDetallesLibros_idx' ('inventario_libro_id' ASC),
  CONSTRAINT 'FKComprobanteDetallesComprobantes'
    FOREIGN KEY ('comprobante_id')
    REFERENCES 'Comprobantes' ('comprobante_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT 'FKComprobanteDetallesLibros'
    FOREIGN KEY ('inventario_libro_id')
    REFERENCES 'InventarioLibros' ('inventario_libro_id')
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);



CREATE TABLE IF NOT EXISTS 'Moras'(
  'mora_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'tipo_mora' VARCHAR(5) NULL,
  'estado_mora' VARCHAR(15) NULL,
  'cantidad' INT NULL DEFAULT 0,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'carnet' VARCHAR(45) NOT NULL
  INDEX 'FKMorasEstudiantes_idx' ('carnet' ASC))
DEFAULT CHARACTER SET = latin1



CREATE TABLE IF NOT EXISTS 'Prestamos'(
  'prestamo_id' INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  'fecha_salida' DATETIME NOT NULL DEFAULT GETDATE(),
  'fecha_devolucion' DATETIME NOT NULL DEFAULT GETDATE(),
  'estado' VARCHAR(50) NULL,
  'created_at' DATETIME NOT NULL DEFAULT GETDATE(),
  'carnet' VARCHAR(45) NOT NULL,
  INDEX 'relacionPL' ('prestamo_id' ASC),
  INDEX 'FKPrestamosEstudiantes_idx' ('carnet' ASC)
DEFAULT CHARACTER SET = latin1