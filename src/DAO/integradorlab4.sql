-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-07-2019 a las 02:01:28
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `integradorlab4`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_userType` (IN `username` VARCHAR(25), IN `TypeCode` INT)  BEGIN

select @userCode := id from usuarios where username = username;
insert into _userType (userCode, userTypeCode) values (@userCode, TypeCode);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos`
--

CREATE TABLE `alumnos` (
  `Id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Apellido` varchar(255) NOT NULL,
  `DNI` varchar(45) NOT NULL,
  `fecha_nac` datetime NOT NULL,
  `Sexo` char(1) NOT NULL,
  `LocalidadCode` int(11) NOT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `alumnos`
--

INSERT INTO `alumnos` (`Id`, `Nombre`, `Apellido`, `DNI`, `fecha_nac`, `Sexo`, `LocalidadCode`, `Direccion`, `Status`) VALUES
(5, 'Francisco Ezequiel', 'Mansilla', '40425829', '1997-07-05 00:00:00', 'M', 1, 'malaga 2192', 'A'),
(6, 'Mabel', 'Mansilla', '40425826', '1987-01-10 00:00:00', 'F', 1, 'malaga 2194', 'A'),
(7, 'Antonella', 'Prato', '40425892', '2006-04-20 00:00:00', 'F', 5, 'malaga 2192', 'A'),
(8, 'Francisco Ezequiel', 'Mansilla', '40425822', '1997-05-07 00:00:00', 'M', 1, 'malaga 2194', 'A'),
(9, 'Rodrigo', 'Rangoni', '40266899', '1994-05-01 00:00:00', 'F', 5, 'Fray justo Sarmiento 2350', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `alumnoCode` int(11) NOT NULL,
  `cursoCode` int(11) NOT NULL,
  `parcial1` int(11) DEFAULT NULL,
  `parcial2` int(11) DEFAULT NULL,
  `recuperatorio1` int(11) DEFAULT NULL,
  `recuperatorio2` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`alumnoCode`, `cursoCode`, `parcial1`, `parcial2`, `recuperatorio1`, `recuperatorio2`, `estado`, `status`) VALUES
(5, 4, NULL, NULL, NULL, NULL, NULL, 'A'),
(6, 3, 8, 8, NULL, NULL, 1, 'A'),
(6, 4, NULL, NULL, NULL, NULL, NULL, 'A'),
(6, 5, 7, 1, 0, 1, NULL, 'A'),
(6, 9, 4, NULL, NULL, NULL, 1, 'A'),
(7, 9, NULL, NULL, NULL, NULL, NULL, 'A'),
(8, 3, NULL, NULL, NULL, NULL, NULL, 'A'),
(8, 5, 6, 2, 0, 3, 2, 'A'),
(9, 5, 7, 3, 0, 10, 1, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

CREATE TABLE `carreras` (
  `Id` int(11) NOT NULL,
  `Descripcion` varchar(45) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `carreras`
--

INSERT INTO `carreras` (`Id`, `Descripcion`, `Status`) VALUES
(1, 'Tecnico Superior en Programacion', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `Id` int(11) NOT NULL,
  `carreraCode` int(11) NOT NULL,
  `MateriaCode` int(11) NOT NULL,
  `semestre` int(11) NOT NULL,
  `year` varchar(45) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`Id`, `carreraCode`, `MateriaCode`, `semestre`, `year`, `Status`) VALUES
(1, 1, 9, 2, '2019', 'A'),
(2, 1, 2, 1, '2019', 'A'),
(3, 1, 4, 1, '2019', 'A'),
(4, 1, 9, 2, '2018', 'A'),
(5, 1, 1, 2, '2019', 'A'),
(6, 1, 11, 2, '2019', 'A'),
(7, 1, 6, 1, '2018', 'A'),
(8, 1, 6, 2, '2018', 'A'),
(9, 1, 1, 1, '2019', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `Id` int(11) NOT NULL,
  `DNI` varchar(45) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Apellido` varchar(255) NOT NULL,
  `Sexo` char(1) NOT NULL,
  `Direccion` varchar(255) DEFAULT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A',
  `LocalidadCode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`Id`, `DNI`, `Nombre`, `Apellido`, `Sexo`, `Direccion`, `Status`, `LocalidadCode`) VALUES
(11, '40425829', 'Francisco Ezequiel', 'Mansilla', 'M', 'malaga 2194', 'A', 1),
(13, '26752523', 'Mabel', 'Mansilla', 'F', 'malaga 2194', 'A', 1),
(14, '40425835', 'Antonella', 'Prato', 'F', 'malaga 2194', 'A', 1),
(15, '40458632', 'Eduardo', 'Prato', 'M', 'malaga 2194', 'I', 1),
(18, '40425887', 'Sara', 'Mansilla', 'F', 'malaga 2194', 'I', 1),
(20, '25869321', 'ana', 'torres', 'F', 'malaga 2192', 'A', 1),
(21, '40425878', 'Ariel', 'Viola', 'M', 'malaga 2192', 'A', 4),
(22, '39654123', 'Daniela', 'Gonzalez', 'F', 'sarratea 1913', 'A', 1),
(23, '40425888', 'juan', 'perez', 'M', 'malaga 2192', 'I', 1);

--
-- Disparadores `docentes`
--
DELIMITER $$
CREATE TRIGGER `docentes_AFTER_INSERT` AFTER INSERT ON `docentes` FOR EACH ROW BEGIN
set @username = (select CONCAT(LEFT(UCASE(NEW.Nombre), 1), UCASE(NEW.Apellido)));
insert into usuarios (userName, password) values (@username, NEW.DNI);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estadoalumno`
--

CREATE TABLE `estadoalumno` (
  `Id` int(11) NOT NULL,
  `Descripcion` varchar(105) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `estadoalumno`
--

INSERT INTO `estadoalumno` (`Id`, `Descripcion`, `Status`) VALUES
(1, 'Regular', 'A'),
(2, 'Libre', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `localidades`
--

CREATE TABLE `localidades` (
  `Id` int(11) NOT NULL,
  `Descripcion` varchar(255) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `localidades`
--

INSERT INTO `localidades` (`Id`, `Descripcion`, `Status`) VALUES
(1, 'Virreyes', 'A'),
(2, 'San Fernando', 'A'),
(3, 'Tigre', 'A'),
(4, 'Jose C. Paz', 'A'),
(5, 'Olivos', 'A'),
(6, 'Pacheco', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `Id` int(11) NOT NULL,
  `Descripcion` varchar(45) NOT NULL,
  `Status` varchar(45) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`Id`, `Descripcion`, `Status`) VALUES
(1, 'Programacion I', 'A'),
(2, 'Programacion II', 'A'),
(3, 'Sistemas de Procesamiento de Datos', 'A'),
(4, 'Ingles I', 'A'),
(5, 'Ingles II', 'A'),
(6, 'Laboratorio de Computacion I', 'A'),
(7, 'Laboratorio de Computacion II', 'A'),
(8, 'Matematica', 'A'),
(9, 'Metodologia de la Investigacion', 'A'),
(10, 'Arquitectura y Sistemas Operativos', 'A'),
(11, 'Diseño y Administracion de Bases de Datos', 'A'),
(12, 'Elementos de Investigacion Operativa', 'A'),
(13, 'Laboratorio de Computacion III', 'A'),
(14, 'Laboratorio de Computacion IV', 'A'),
(15, 'Legislacion', 'A'),
(16, 'Metodologia de Sistemas I', 'A'),
(17, 'Organizacion Contable de la Empresa', 'A'),
(18, 'Organizacion Empresarial', 'A'),
(19, 'Programacion III', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relationalumnocurso`
--

CREATE TABLE `relationalumnocurso` (
  `AlumnoCode` int(11) NOT NULL,
  `CursoCode` int(11) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `relationalumnocurso`
--

INSERT INTO `relationalumnocurso` (`AlumnoCode`, `CursoCode`, `Status`) VALUES
(5, 4, 'A'),
(6, 3, 'A'),
(6, 4, 'A'),
(6, 5, 'A'),
(6, 9, 'A'),
(7, 9, 'A'),
(8, 3, 'A'),
(8, 5, 'A'),
(9, 5, 'A');

--
-- Disparadores `relationalumnocurso`
--
DELIMITER $$
CREATE TRIGGER `relationalumnocurso_AFTER_INSERT` AFTER INSERT ON `relationalumnocurso` FOR EACH ROW BEGIN
insert into calificaciones (alumnoCode, cursoCode) values (new.AlumnoCode, NEW.CursoCode);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `relationcursodocente`
--

CREATE TABLE `relationcursodocente` (
  `CursoCode` int(11) NOT NULL,
  `DocenteCode` int(11) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `relationcursodocente`
--

INSERT INTO `relationcursodocente` (`CursoCode`, `DocenteCode`, `Status`) VALUES
(1, 14, 'A'),
(2, 14, 'A'),
(3, 4, 'A'),
(3, 13, 'I'),
(3, 21, 'A'),
(4, 13, 'A'),
(5, 4, 'A'),
(5, 20, 'A'),
(6, 22, 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usertypes`
--

CREATE TABLE `usertypes` (
  `Id` int(11) NOT NULL,
  `Descripcion` varchar(50) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usertypes`
--

INSERT INTO `usertypes` (`Id`, `Descripcion`, `Status`) VALUES
(1, 'Administrador', 'A'),
(2, 'Docente', 'A'),
(3, 'Alumno', 'I'),
(4, '', 'I');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `Id` int(11) NOT NULL,
  `UserName` varchar(100) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `AddDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`Id`, `UserName`, `Password`, `AddDate`, `Status`) VALUES
(1, 'Admin', 'Admin', '0000-00-00 00:00:00', 'A'),
(2, 'FMANSILLA', '40425829', '2019-06-22 17:01:02', 'A'),
(4, 'MMANSILLA', '26752523', '2019-06-28 22:29:18', 'A'),
(5, 'APRATO', '40425835', '2019-06-28 23:22:48', 'A'),
(6, 'EPRATO', '40458632', '2019-06-29 09:14:33', 'I'),
(9, 'SMANSILLA', '40425887', '2019-06-29 10:02:16', 'I'),
(11, 'ATORRES', '25869321', '2019-07-04 19:20:58', 'A'),
(12, 'AVIOLA', '40425878', '2019-07-10 19:06:41', 'A'),
(13, 'DGONZALEZ', '39654123', '2019-07-10 20:53:11', 'A'),
(14, 'JPEREZ', '40425888', '2019-07-12 20:25:06', 'I');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_alumnos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_alumnos` (
`code` int(11)
,`nombre` varchar(255)
,`apellido` varchar(255)
,`dni` varchar(45)
,`fecha_nac` datetime
,`sexo` char(1)
,`localidadCode` int(11)
,`localidadDescripcion` varchar(255)
,`direccion` varchar(255)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_calificaciones`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_calificaciones` (
`alumnocode` int(11)
,`AlumnoDescripcion` varchar(512)
,`cursocode` int(11)
,`parcial1` int(11)
,`parcial2` int(11)
,`recuperatorio1` int(11)
,`recuperatorio2` int(11)
,`estadoCode` int(11)
,`estadoDescripcion` varchar(105)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_cursos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_cursos` (
`CursoCode` int(11)
,`CarreraCode` int(11)
,`CarreraDescripcion` varchar(45)
,`MateriaCode` int(11)
,`MateriaDescripcion` varchar(45)
,`semestre` int(11)
,`year` varchar(45)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_cuursosforalumno`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_cuursosforalumno` (
`cursoCode` int(11)
,`carreraCode` int(11)
,`carreraDescripcion` varchar(45)
,`materiaCode` int(11)
,`materiaDescripcion` varchar(45)
,`semestre` int(11)
,`year` varchar(45)
,`docenteCode` int(11)
,`alumnoCode` int(11)
,`status` char(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_cuursosfordocente`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_cuursosfordocente` (
`cursoCode` int(11)
,`carreraCode` int(11)
,`carreraDescripcion` varchar(45)
,`materiaCode` int(11)
,`materiaDescripcion` varchar(45)
,`semestre` int(11)
,`year` varchar(45)
,`docenteCode` int(11)
,`status` char(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_docentes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_docentes` (
`docenteCode` int(11)
,`userCode` int(11)
,`Nombre` varchar(255)
,`Apellido` varchar(255)
,`dni` varchar(45)
,`sexo` char(1)
,`localidadCode` int(11)
,`localidadDescripcion` varchar(255)
,`direccion` varchar(255)
,`username` varchar(100)
,`usertypecode` int(11)
,`userTypeDescripcion` varchar(50)
,`adddate` datetime
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `v_usuarios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `v_usuarios` (
`userCode` int(11)
,`UserName` varchar(100)
,`UserTypeCode` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `_usertype`
--

CREATE TABLE `_usertype` (
  `Code` int(11) NOT NULL,
  `UserCode` int(11) NOT NULL,
  `UserTypeCode` int(11) NOT NULL,
  `Status` char(1) NOT NULL DEFAULT 'A'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `_usertype`
--

INSERT INTO `_usertype` (`Code`, `UserCode`, `UserTypeCode`, `Status`) VALUES
(1, 1, 1, 'A'),
(4, 2, 2, 'A'),
(6, 4, 2, 'A'),
(9, 9, 2, 'A'),
(10, 5, 2, 'A'),
(11, 6, 2, 'A'),
(12, 10, 2, 'A'),
(13, 11, 2, 'A'),
(14, 12, 2, 'A'),
(15, 13, 2, 'A'),
(16, 14, 2, 'A');

-- --------------------------------------------------------

--
-- Estructura para la vista `v_alumnos`
--
DROP TABLE IF EXISTS `v_alumnos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_alumnos`  AS  select `a`.`Id` AS `code`,`a`.`Nombre` AS `nombre`,`a`.`Apellido` AS `apellido`,`a`.`DNI` AS `dni`,`a`.`fecha_nac` AS `fecha_nac`,`a`.`Sexo` AS `sexo`,`l`.`Id` AS `localidadCode`,`l`.`Descripcion` AS `localidadDescripcion`,`a`.`Direccion` AS `direccion` from (`alumnos` `a` join `localidades` `l` on((`a`.`LocalidadCode` = `l`.`Id`))) where (`a`.`Status` = 'A') ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_calificaciones`
--
DROP TABLE IF EXISTS `v_calificaciones`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_calificaciones`  AS  select `c`.`alumnoCode` AS `alumnocode`,concat(`a`.`Nombre`,', ',`a`.`Apellido`) AS `AlumnoDescripcion`,`c`.`cursoCode` AS `cursocode`,`c`.`parcial1` AS `parcial1`,`c`.`parcial2` AS `parcial2`,`c`.`recuperatorio1` AS `recuperatorio1`,`c`.`recuperatorio2` AS `recuperatorio2`,`c`.`estado` AS `estadoCode`,`e`.`Descripcion` AS `estadoDescripcion` from ((`calificaciones` `c` left join `estadoalumno` `e` on((`e`.`Id` = `c`.`estado`))) left join `alumnos` `a` on((`c`.`alumnoCode` = `a`.`Id`))) where (`c`.`status` = 'A') ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_cursos`
--
DROP TABLE IF EXISTS `v_cursos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cursos`  AS  select `c`.`Id` AS `CursoCode`,`c`.`carreraCode` AS `CarreraCode`,`cr`.`Descripcion` AS `CarreraDescripcion`,`c`.`MateriaCode` AS `MateriaCode`,`m`.`Descripcion` AS `MateriaDescripcion`,`c`.`semestre` AS `semestre`,`c`.`year` AS `year` from ((`cursos` `c` join `materias` `m` on((`m`.`Id` = `c`.`MateriaCode`))) join `carreras` `cr` on((`cr`.`Id` = `c`.`carreraCode`))) where (`c`.`Status` = 'A') ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_cuursosforalumno`
--
DROP TABLE IF EXISTS `v_cuursosforalumno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cuursosforalumno`  AS  select `c`.`CursoCode` AS `cursoCode`,`c`.`CarreraCode` AS `carreraCode`,`c`.`CarreraDescripcion` AS `carreraDescripcion`,`c`.`MateriaCode` AS `materiaCode`,ltrim(`c`.`MateriaDescripcion`) AS `materiaDescripcion`,`c`.`semestre` AS `semestre`,`c`.`year` AS `year`,`rd`.`DocenteCode` AS `docenteCode`,`r`.`AlumnoCode` AS `alumnoCode`,`r`.`Status` AS `status` from ((`v_cursos` `c` left join `relationalumnocurso` `r` on((`r`.`CursoCode` = `c`.`CursoCode`))) left join `relationcursodocente` `rd` on((`rd`.`CursoCode` = `c`.`CursoCode`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_cuursosfordocente`
--
DROP TABLE IF EXISTS `v_cuursosfordocente`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_cuursosfordocente`  AS  select `c`.`CursoCode` AS `cursoCode`,`c`.`CarreraCode` AS `carreraCode`,`c`.`CarreraDescripcion` AS `carreraDescripcion`,`c`.`MateriaCode` AS `materiaCode`,ltrim(`c`.`MateriaDescripcion`) AS `materiaDescripcion`,`c`.`semestre` AS `semestre`,`c`.`year` AS `year`,`r`.`DocenteCode` AS `docenteCode`,`r`.`Status` AS `status` from (`v_cursos` `c` left join `relationcursodocente` `r` on((`r`.`CursoCode` = `c`.`CursoCode`))) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_docentes`
--
DROP TABLE IF EXISTS `v_docentes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_docentes`  AS  select `d`.`Id` AS `docenteCode`,`u`.`Id` AS `userCode`,`d`.`Nombre` AS `Nombre`,`d`.`Apellido` AS `Apellido`,`d`.`DNI` AS `dni`,`d`.`Sexo` AS `sexo`,`l`.`Id` AS `localidadCode`,`l`.`Descripcion` AS `localidadDescripcion`,`d`.`Direccion` AS `direccion`,`u`.`UserName` AS `username`,`_ut`.`UserTypeCode` AS `usertypecode`,`ut`.`Descripcion` AS `userTypeDescripcion`,`u`.`AddDate` AS `adddate` from ((((`docentes` `d` join `localidades` `l` on((`l`.`Id` = `d`.`LocalidadCode`))) left join `usuarios` `u` on((`u`.`Password` = `d`.`DNI`))) join `_usertype` `_ut` on((`u`.`Id` = `_ut`.`UserCode`))) join `usertypes` `ut` on((`_ut`.`UserTypeCode` = `ut`.`Id`))) where ((`d`.`Status` = 'A') and (`u`.`Status` = 'A')) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `v_usuarios`
--
DROP TABLE IF EXISTS `v_usuarios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuarios`  AS  select `u`.`Id` AS `userCode`,`u`.`UserName` AS `UserName`,`_ut`.`UserTypeCode` AS `UserTypeCode` from (`usuarios` `u` join `_usertype` `_ut` on((`u`.`Id` = `_ut`.`UserCode`))) where (`u`.`Status` = 'A') ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  ADD KEY `localidad_idx` (`LocalidadCode`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`alumnoCode`,`cursoCode`);

--
-- Indices de la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `materia_idx` (`MateriaCode`),
  ADD KEY `carrera_idx` (`carreraCode`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `localidad_idx` (`LocalidadCode`);

--
-- Indices de la tabla `estadoalumno`
--
ALTER TABLE `estadoalumno`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `localidades`
--
ALTER TABLE `localidades`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `relationalumnocurso`
--
ALTER TABLE `relationalumnocurso`
  ADD PRIMARY KEY (`AlumnoCode`,`CursoCode`);

--
-- Indices de la tabla `relationcursodocente`
--
ALTER TABLE `relationcursodocente`
  ADD PRIMARY KEY (`CursoCode`,`DocenteCode`);

--
-- Indices de la tabla `usertypes`
--
ALTER TABLE `usertypes`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `_usertype`
--
ALTER TABLE `_usertype`
  ADD PRIMARY KEY (`Code`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumnos`
--
ALTER TABLE `alumnos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `carreras`
--
ALTER TABLE `carreras`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `estadoalumno`
--
ALTER TABLE `estadoalumno`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `localidades`
--
ALTER TABLE `localidades`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `materias`
--
ALTER TABLE `materias`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `usertypes`
--
ALTER TABLE `usertypes`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `_usertype`
--
ALTER TABLE `_usertype`
  MODIFY `Code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumnos`
--
ALTER TABLE `alumnos`
  ADD CONSTRAINT `localidad` FOREIGN KEY (`LocalidadCode`) REFERENCES `localidades` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `carrera` FOREIGN KEY (`carreraCode`) REFERENCES `carreras` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `materia` FOREIGN KEY (`MateriaCode`) REFERENCES `materias` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
