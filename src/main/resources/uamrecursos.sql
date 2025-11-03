-- ===========================================================
-- 5. TABLA: Recurso
-- ===========================================================

CREATE TABLE Usuario (
                         id_usuario INT AUTO_INCREMENT PRIMARY KEY,
                         nombre VARCHAR(100) NOT NULL,
                         correo VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE Materia (
                         id_materia INT AUTO_INCREMENT PRIMARY KEY,
                         nombre_materia VARCHAR(100) NOT NULL
);

CREATE TABLE Tema (
                      id_tema INT AUTO_INCREMENT PRIMARY KEY,
                      nombre_tema VARCHAR(100) NOT NULL,
                      id_materia INT,
                      FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
                          ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Recurso (
                         id_recurso INT AUTO_INCREMENT PRIMARY KEY,
                         titulo VARCHAR(200) NOT NULL,
                         descripcion TEXT,
                         tipo_recurso ENUM('video', 'artículo', 'guía', 'ejercicio', 'documento') NOT NULL,
                         enlace_o_ubicacion VARCHAR(255),
                         fecha_publicacion DATETIME DEFAULT CURRENT_TIMESTAMP,
                         estado ENUM('pendiente', 'aprobado', 'rechazado') DEFAULT 'pendiente',
                         tipo_origen ENUM('oficial', 'compartido') DEFAULT 'compartido',
                         id_usuario_compartio INT,
                         id_moderador_reviso INT,
                         id_materia INT,
                         id_tema INT,
                         FOREIGN KEY (id_usuario_compartio) REFERENCES Usuario(id_usuario)
                             ON UPDATE CASCADE ON DELETE SET NULL,
                         FOREIGN KEY (id_moderador_reviso) REFERENCES Usuario(id_usuario)
                             ON UPDATE CASCADE ON DELETE SET NULL,
                         FOREIGN KEY (id_materia) REFERENCES Materia(id_materia)
                             ON UPDATE CASCADE ON DELETE SET NULL,
                         FOREIGN KEY (id_tema) REFERENCES Tema(id_tema)
                             ON UPDATE CASCADE ON DELETE SET NULL
);

-- ===========================================================
-- 6. TABLA: Historial_Consulta
-- ===========================================================
CREATE TABLE Historial_Consulta (
                                    id_historial INT AUTO_INCREMENT PRIMARY KEY,
                                    id_usuario INT NOT NULL,
                                    id_recurso INT NOT NULL,
                                    fecha_consulta DATETIME DEFAULT CURRENT_TIMESTAMP,
                                    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
                                        ON UPDATE CASCADE ON DELETE CASCADE,
                                    FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
                                        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ===========================================================
-- 7. TABLA: Favorito
-- ===========================================================
CREATE TABLE Favorito (
                          id_favorito INT AUTO_INCREMENT PRIMARY KEY,
                          id_usuario INT NOT NULL,
                          id_recurso INT NOT NULL,
                          fecha_agregado DATETIME DEFAULT CURRENT_TIMESTAMP,
                          UNIQUE (id_usuario, id_recurso), -- evita duplicar favoritos
                          FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
                              ON UPDATE CASCADE ON DELETE CASCADE,
                          FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
                              ON UPDATE CASCADE ON DELETE CASCADE
);

-- ===========================================================
-- 8. TABLA: Encuesta_Satisfaccion
-- ===========================================================
CREATE TABLE Encuesta_Satisfaccion (
                                       id_encuesta INT AUTO_INCREMENT PRIMARY KEY,
                                       id_usuario INT NOT NULL,
                                       id_recurso INT NOT NULL,
                                       calificacion TINYINT CHECK (calificacion BETWEEN 1 AND 5),
                                       comentario TEXT,
                                       fecha_respuesta DATETIME DEFAULT CURRENT_TIMESTAMP,
                                       FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
                                           ON UPDATE CASCADE ON DELETE CASCADE,
                                       FOREIGN KEY (id_recurso) REFERENCES Recurso(id_recurso)
                                           ON UPDATE CASCADE ON DELETE CASCADE
);