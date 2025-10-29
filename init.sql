-- Crear base de datos
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'MascotasDB')
BEGIN
    CREATE DATABASE MascotasDB;
END
GO

USE MascotasDB;
GO

-- Crear tabla de mascotas
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Mascotas' AND xtype='U')
BEGIN
    CREATE TABLE Mascotas (
        id INT IDENTITY(1,1) PRIMARY KEY,
        nombre NVARCHAR(100),
        especie NVARCHAR(50),
        raza NVARCHAR(50),
        edad INT,
        peso DECIMAL(5,2),
        color NVARCHAR(50)
    );

    -- Insertar datos de ejemplo
    INSERT INTO Mascotas (nombre, especie, raza, edad, peso, color) VALUES
    ('Firulais', 'Perro', 'Labrador', 5, 25.5, 'Marrón'),
    ('Michi', 'Gato', 'Siames', 3, 4.2, 'Blanco y gris'),
    ('Rex', 'Perro', 'Pastor Alemán', 7, 30.0, 'Negro y marrón'),
    ('Luna', 'Gato', 'Persa', 2, 3.5, 'Blanco'),
    ('Nube', 'Perro', 'Husky', 4, 22.8, 'Blanco y gris');
END
GO
