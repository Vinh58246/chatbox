-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 26, 2024 at 03:37 PM
-- Server version: 8.0.30
-- PHP Version: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `send_message`
--

-- --------------------------------------------------------

--
-- Table structure for table `emoji`
--

CREATE TABLE `emoji` (
  `id_emoji` int NOT NULL,
  `icon` varchar(225) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_message_icon` int NOT NULL,
  `id_user_icon` int NOT NULL,
  `ho_ten_drop` varchar(225) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `message`
--

CREATE TABLE `message` (
  `id_message` int NOT NULL,
  `content` text COLLATE utf8mb3_unicode_ci NOT NULL,
  `img_content` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `id_user` int NOT NULL,
  `time_send` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `message`
--

INSERT INTO `message` (`id_message`, `content`, `img_content`, `id_user`, `time_send`) VALUES
(375, 'hehe', NULL, 72, '20:45:09');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id_user` int NOT NULL,
  `ho_ten` varchar(225) COLLATE utf8mb3_unicode_ci NOT NULL,
  `email` varchar(225) COLLATE utf8mb3_unicode_ci NOT NULL,
  `phone` int NOT NULL,
  `token` varchar(225) COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `avatar_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sex` varchar(10) COLLATE utf8mb3_unicode_ci NOT NULL,
  `password` varchar(225) COLLATE utf8mb3_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id_user`, `ho_ten`, `email`, `phone`, `token`, `avatar_user`, `sex`, `password`) VALUES
(72, 'vinh', 'a@gmail.com', 2154846, NULL, 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxISEBMRERIWERUWFRgXGBUWFhUXFxYdGRcYGBcVFhgZHiggGholGxgVITEiJSkrLi4uFyAzODMsNyktMCsBCgoKDg0OGhAQGy0lICUtLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAwADAQEAAAAAAAAAAAAABQYHAgMEAQj/xABLEAABAwIDBAYGBgcECQUAAAABAAIDBBEFEiEGMUFRBxMiYXGBFDJSkaGxI0JicpKiFTNUgpPB0RaDstIkNENEU2NkwvBFVXPD4f/EABkBAQADAQEAAAAAAAAAAAAAAAABAgQDBf/EACMRAQACAQMFAAMBAAAAAAAAAAABAhEDITEEEhNBURQiYTL/2gAMAwEAAhEDEQA/ANwREQEREBERAREQEREBERAREugIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICLqqahsbHPe4Ma1pc5xNg0AXJJ4ABYjtb0rVMzyyhPo8INhJlBlk+12gQwHla/MjcIm0QtWs24bmi/MUO2GItdmFdUX+1I54/C67fgtI2N6V2OjezESI3saXCVjTaS31cgvaTw0Ou62tYvC1tKYaqozGtoKWkbmqZ2Q8g49p33WC7neQWdz7UYnielCz0CmOnXvt1rx9i27938YXbhewVJG7rJs1ZKdXPmJcCeeXcf3sx71W2pHp0p09rcvZUdKzJCW0FFUVh9rKWM8zZzh5gLyPxvaCe+SGmo28M5zO993j8oVnjYGgNaA0DcAAAPABclSb2lor09IVL9G42718WDfuxMt8GNT9D4x/7w7+E1W1FXM/V/DT4qfomPM9TFI39z4ox/8AUSuxuObQQ6vhpascchyu95c0flKtCKe6yJ0KT6QMHSoIyG4hQz0Z3ZwC+PxuQ0n90FXPBNoKWrbmpp2SjiGntN+8w2c3zAUS9gILXAEHeCLg+IVWxXYSme4S0xdRTDVskJLQD90EW/dLVaNSfblfpo9NSRZZQbbVmHvbDizOuiJsyriF/APAAufIO7nb1S9q+kasq3uEUj6WG/ZjjdleRwMkjdSTyBtw13np3wzeK2cS/Q6L8r0uPVkbg+OrnaR/zZD7wTY+YWudG3SM6qe2krLCYj6OQAAS2Fy1wGjX2BOlgbHQHQovEltKYjLTERFdzEREBERAREQEREBERBnXThiD46BkTDYTTBr+9rWueW+bms8gVhi/QvSvgTqvD3dW0ukheJmtG92UOa9o5nI5xA4kBfnlpvqFxvy06WO19X1r8pDgAbEGxFwba2I4juXxTGyuBOralsQByCzpXeyzlf2nWIHv4FUdYbrTvDmNcBYFoIHK4vZc18aABYaAL6qtUCIikERFAIiKQREQddTTskY6ORoexws5rgCCORBWRbb7GOpCZoLvgJ1B1dETwceLeTvI8zsK4yxtc0tcA5rgQQRcEEWII4iyK2rEvziuUc7o3NkYcr2EPaeTmnM0+8BWHbfZo0U/YuYZLmM78vOMnmOHMeBXj2UwB9dVx0zQS0kGU8GRg9txPDTQd5CmN2eduX6cpJs7GPtbM0Ot4gFdq+NaBoNF9WlhEREBERAREQEREBERB8Kw7aXAIa7GJ4KQNp2xNvPK1pc0ynfZlwAbmxta5a871ru1OMCjo56k2+jYS0H6zjoxvm4tHmqJ0dYaYqMSyay1BMz3Hec2rb+IObxeVy1Z9NHT0zOVep+ivtfSVd28mRZXHwJeQPcVfMIwmGliEUDMjd54lx9px3kr2ouLdFYgREUrCKI2i2jp6JmaZ3aPqxtsXvtyHAd50UNR4NiuKduZ5wylO6Nt+ueO/cR+9YfZKREzw531K05TWK7S0lNcTTsa4fUBzP8AwtuR5qCHSHFISKWkqaq3GOO4/LmPwVvwLo6w6lALacTPH+0mtI6/MAjK0/daFamMAFgLAbgNAF0jS+s1uq+Qypu0WKP9TBpQPtvc0+YdG1cjjWLj/wBHd/FH9FqtkU+KFPybskfttPF/reF1UAG9zWuc3xzOa1vxUlhW21BUWDJwxx+rJ2DrwBPZJ8CtJUDjux1DVg9fTsLj/tGjJJ+NtifA3CidL4tXqp9vKEVPrNk8Rwv6TD5XVtONTTSavaOOQDfpf1LfdcpbZraaCtYTGSyRvrxO9dvAnvbfiPOx0XOYmOWqmrW/Dv2kwdlXTPgdoSLsd7Dx6rv5HmCQvL0L1EQppqbqmxVMMpbNb1n6nI9x3m1nN5dnS11OqmYlJ+j8Zpq0aRVP0E3K5sA48t0bv7t3NTScS59RTNdmtoiLS88REQEREBERAREQERCgzbpcmM8lDhjSfp5esksbdhmn83u8YwrA1oAAAsBoBy7lU43+k7Q1cp1bSxNhb3E7/iZwras15zL0enrigiIodxV/a3aQUjGsjb1tRKcsUQuSSTbMQNbX0tvJ05kSeNYmylgknk9Vgvbi47mtHeTYKO6NdnXyPOLVovPNrC07oYyLAtHAlu7iGnm5ymte6XHV1OyHp2K2E6t/p2IH0isd2hms5sPING4uHMaDc3mb6iLREYedNpmcyIiKUCIiAiIgKh7c7DmV3p1CeprGdrs2Amt9V3DMRpc6Hc7SxF8RRMZTEzE5hnOyO0QrI3B7erniOWWI3BaQbXAOtrg6HUEEHv4bfYZ6Rh8zbXcwdY3ndmpA7y3MP3lx6ScDfTStxijbZ8elQwaCSPQF5tyFgTyAd9VTOG1sdRCyaM5mSNuPPQtPeDcEcws9q4l6OnqeSqT2Exb0vDqacm7jGGvP22dh583NJ81PrN+hqXqxXUJJvT1BLQfZddot3XjJ/eWkLvWcw8+8YtMCIisqIiICIiAiIgL4V9XmxKTLDI7kxx9zSUGWdGR6xlZU8Z6p7r8x6/zkcroqj0Usthkfe+Q+52X+Styye3rUjECIvJi1c2nglndqI2F1udho0d5Nh5osrOIU/wCk8Vjod9NS2lqOTnfVjPvA8HSclrDRYWCo3RDhbo6I1UustW8zOdzaScnkdX/3ivS0UriHmat+6wiLKtp+lzqah8NJA2Vsbi10r3EBzgbODGgeqDcZidbaC1ibTOHOKzPDVUVT2C21jxKN/Y6mWO2eO+YWN7PY6wu02I3XB8ibYkTkmMbSIiKUCICuqpnbGx0jyGtY0uc47gALknwAQdqLGcQ6ZputPo9NH1QOnWl+dw5nKQGE8tVpGxe08eI0wnY0scHFkkZNyxwANr8QQQQeR4G4VYtErTS0bym5ow5pa4BzSCCDqCDoQe5ZPs7GcOxGfC3k9U+81MSfqm92a8bAjxjcfrLW1knThK6Gow+pj0ewykeLXROAPdvHmVXUjMOmhbFnr2Zd1O0dQz6tRTB9vtNyAf4ZPetQWRira7G8Jqo/VnhcPEGOQgHzkC1wJp8GvH7iIi6OIiIgIiICIiAvPiEeaGRvtMcPe0hehCgyjookvhkY9l8gPm7N/wByt6puwDeomxGiOhhqXOaPsuu1pHkxp/eCuSyPWpOYyKndJD3SMpqFhs6qnYzwaCLnyc5h8lcVSsUvLj9Iw+rFA6Tzd1o/ye5SX4abDURRMbGw2axoa0AXADRYD3BeiGsY42DteR0+ar6K/kln/FrjlaF+W9qMCloKh8M7S0BxySH1ZG37Lmu3E2tccCv0rhlUXAtOpHHmF7i2+9dNrxlliZ07TEsk6EMAmY+askY6Nj4xHHmBBfdwc54B+qMrQDxueS1xEVojEKWtmcqrt3VVkQpZaVksjGTh07IGtfK9gB7Iad7SdDbXUbt6iGbUYs1/pL8MeaR3ZELLGrZbdI5nG+7LYW8ru0FEwmJ/it7ASVbqQurQ8PdLIWCUNbIIybsEgbYB2/TlZSm0GH+k0lRT3y9bE+O/LO0tB+KkERGd8vypiGEVEEpgmheyQG2XKTm72EDtjvF1t3Q9s/NSUcjp2mN80geGO0c1oaGtzDg46m28C17G4V9sumqlyNLuX/gVYrjde2pNtsOUszWi5ICzTpRmZLWYTGLPvO64I0IzQ3BB3jerVLIXG7jcqj9I30UlBVDQx1IafB1nEe6MjzXO2plpr0/b+08uzaxojxHB3tAaBUdXYaABzomgActVrKyfbgXrcIaN/pjD5CSG61gK2lw5dT/oREXVnEREBERAREQEREGW7Zs9AxmGuPZhqmdTKeAeAAHO8mxnwY5WpSW1OAx11LJTS6Bwu1w3scPVe3vB94JHFZzs/jclHL+jcS+jkZpFMT2JW7m9o+4E79xs4a8NSu+W3p9TbtldFSMVd1OPUsjtGzQGMH7X0mnvMY/eV3Vd24wF1XTgxG08LusiO43G9t+F7C3e1q5tNuFiRV3ZDadlWzI/6OpZpJEeybjQuaDwvvG9p0PAmxtFzYalExO2Xtwj9Yfun5hTS8eHUmRtzvPw7l7FopGIebrWi15mBERXchERAREQF4MZ/Vj7w+RXvXVVRB7S0qtozGFqW7bRMq4qV0qHNT08I9aSpYAOPqvHzc33q5YjM2BrnzOEbWi5c42H/wCrOmYk2rqjic946OkuIQ4ayycMo4uvY24FrRwcsz07TExsm69vX7QYfCNRAx8z+64JHxbH+ILVQs56KcMkkdUYrUNs+p0iHsxAjd3HKwDmIweK0ZaNOMQ8/Wt3XERFdyEREBERAREQEREBRG0ezlNXRdVUxh43tcNHsPtMdvB+B4gqXWXbb7ZTVLpMOwlkssoNppoho0agsY+/ZNxYvNhoQDfUVtMJrEzOyLxEVeCuyieKtpRujklYyeMcg0m/L1Q4fZapXCdvaGcAOk9Hd7M3ZHk/Vvxv3Ks7E7O0j5J6aspCyqhsXh0jjmDhe9muy3uRzFnN1VxdsZh5BHorPLMD7wVnnGXoafdjnLox7ZSnrCJ43mGYatnhOpsLAuse1bmCD3rx0mI43Q6GKLEYx9YdmW3C5Fj+V3iuEvRzA0l1LPPSOPsPuP5OP4l0z4XitMLtxKKRo4VDQy/mQ4/mSJxwm1YnmE1B0u07CG1dLU0jvtMBb4alrj+FTFJ0mYVJuqg378crPi5tvis3qdvKyHsy+hVA3HqpM3vyvPyXjbtrSyutLhUMjj7ORzj5GO/xV/JLhOjT62SPbbDTurqbzmYPmV7Y9oKR3q1UDvCaM/IrCsTxelA0wXIPakMkdvJrR810U1bhJjDp8Ona/W5ie8x79C0ulB3W38eanySr4I+v0F+lYP8AjxfxGf1XVLj9I31qqBvjNGPmVgzf0Q4XZhlY6+6xdr7pCumZtK53U0mEydce0BNJOTbeT1YcCdONx5p5J+I/H/rcJtt8Nbvrqc9zZWuPuaSo6o6UMKZoarN92Kd3xDLLL/RaiNl/0FETzyySfkzuco2baeeI29DpaS540mQ/nuT7k8kreCPctRn6YcOGkTZ6h3BrIwD+dzSvDWdItfK0mlw4wt/41U7I0d5Dsgt4OKp9Diskws/G2U4O9rIXR27g7LH81OYdsXQTOD5Kx9ee+drh+Ul35lE6krRoVVvGMWE8jXV1S7EpAexTQEsp2k7ryWAO8DsAnm4q77O9H81S5k+K5WsYB1NDHYRRgbg8N0/dBN+JI7K9lTsbQvi6o0zGjg5oyvHfn3k+JKp+ze19Xhk8lPM509HBKIn3F3RBxd1b2Ea2s0nKbjSwtoorMZ3TqVtEfq3NjABYCwGgA3DuC5LjG8OAINwRcEcQdxXJaGIREQEREBERAREQEREHg2ge8UlQYv1ghkLLb8wY7Lbzss/6PcQjo8BbUQU76l5kd1kcLc0jndYWi4AvYMycDpZaesu2m2RqqB0lbg0j2BxzS0rQHtI3l0bCCHAexa4BOU7mqtvq9d9lYq8arpcXNRFQGCeSnDeomJBLAf1rs3VkeqBb7PFTfo2Oy75qamH2QHEe9rvmoTZbaUT4jJW188MTxD1IGrNzhwNwLWdfXedyvJ2oof2yn/jR/wBVnnlv04/XdA/2Mq5D/pGKTOHsxhzB/jt+VdlP0a0IN5Otncd5fJYnzYGlSVRtph7Bc1TD9wPf/gBU7G8OAcDcEAg8wdQVC8Vqh6XZKgjtlpIjbi5uc+991LwQtYLMaGDk0AD4LmiLYhUtr8NqayogpQ0spB9JNID6xBP0e+97DTvff6q6+kuXq8PbTxDL1skcTGjQAA5gB3dho81cVC45gAqZ6WV0ha2nkMmTLcPPZLdb6WLRz0JRWapWipxFEyJu5jGsHg0AD5Kqbe4bKDDX0zS+encLtaCS9hOrbAEm1yPB7lcERaYzGHGF+ZrXWLbgGx3i4vY94XJ2osdRyREwlVdsG0NOyOSejjlD5WxlwYwFtwSXl1r6AFfKvo6w597ROj+5I74BxI+CdJ8GbDJT7Lo3fnDT8HFeSk2wrJGM6jCqmW7R2yHtY7QdoO6sgg+KnE+nK0xE7n9gXx/6tiNTDbcC7M33MLAqDiE07JK2Hr2zukljhkGW753Me7K5gsbFr2gbxq5o1Wj5cfqeyylioWnTrJHtLh3ixcR+BWHY/o6pqJzZnk1FRv61+5pPrGNvDjqSXanXVWrSXDU1aeli2bpHw0dNDIbvjgiY483NY1rviCpJEWhjEREBERAREQEREBERAREQROJ7M0VQ7NPSwyu9tzG5/wAW/wCKpu3+yOHUuG1M8dKxj2sAY4F1w57msBFzbQuWkKhdNs1sJe325Ym+4l//AGKto2WpnMQjdlNnKUUlM99NE6R0THOc6NjnXc0OOpHerOuumjyxsb7LWt9wAXYsz1YjYREUpEREBERAREQQW3MebDaof8u/4SHfyVm2CkzYXQn/AKaIe5gH8lAbWtvh9WP+nl+DHFS3Ri++E0f/AMZHue4fyV9Llj6r0tFkRF3YxERAREQEREBERAREQEREBERAWc9NutNRs9usjB/hyf1WjLOemc9jDyd3prL/AIXKt+F9P/UJ8r4hRZnqiIikEREBERAREUDwY+zNR1LecEo98bl3dEUl8Hpf70e6eQLhjLw2mnLjZoikJPIZDdfOhxpGD09xbtTEeBnk1XTS5ZOq4hdURF3YhERAREQEREBERAREQEREBERAURtRs9DX07qecGxN2uFszHC9ntvx1I5EEjipdEOGRVEeLYSw9a1uIUrB+sDssjGi3rXu4DfvDx9oLso+kqgf+sdJA7k5hd8WX0WlY7SMnppoHkASxPjueGdpbf4qidFtZDLTHDatjHVFM57THK1ri5mYkFuYahpJbpwDTxC4zSMtNOotFXfFtfQO1FXEPvOy/B1l2Damg/bIPOVg+ZUriuy2ERMdLPS0sTBqXFjGD4Wue5Z9s1gtLXV01UykayhYOrijILRK7jIRe/M912jeCqzTHt0jqds4Wz+1FB+2U/8AGj/qn9qaD9sp/wCLH/Vczshhv7DD+f8AzINkMO/YYfz/AOZOw/Kj463bVUA/3yDykafkuiXbXD276ph8A93+FpXubsrhw/3CnPiwn5lVXa/CIqKpgxCGjifTs7E9O2NmSxJAkDSLZu1v5tbwJTsI6nO0Q9k/SThzd0j3nk2Nwv8AjsvHXdIhbGZIqCoLBa8koMcYubC7mhw1JFtdbq7YTtfg/Vh8dRSwaeq4xwvHcWOsVTtpsdjxqtgw+B/+isf1k0hu0y5dC1gNiRYkDvdm3NuZ7IiOUee0+nZBgOK4oxnpLo6KkkDXlrNZXtNnN0JO8a6kW0u07lqWH0TIImQxNysjaGtHIAWC5QTMIs0juG63ku5da1iOGa95tyIiKygiIgIiICIiAiIgIiICIiAiIgIURBCz0sgNyC7vGqoG2mwRqZTU08ginNswdcNcWjKHBw1Y6wA3G9hu46yvhaqzVMWmOH5srtjcTLrSQSS23O61rx4gl9x52WwbNwSMo4GTNayRsbQ5rA0NBHABvZva17aXvZW807D9Ue4LiaOP2Qq9i1rzZBopr0GP2fif6p6DH7Pxd/VT2yohVwnha9rmPaHtcCHNcLgg6EEHgp4UUfs/NchSs9ke5O2RkWLdFsD3F1PM6C/1HN6xo7mm4cB4krt2Z6MnQVMc7qgydW7M1rIi251HacXHTXdZa22MDcAPJc07IX8lkTBQOJ17PzUsiK0RhQREUgiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIg//Z', 'male', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `emoji`
--
ALTER TABLE `emoji`
  ADD PRIMARY KEY (`id_emoji`),
  ADD KEY `id_message` (`id_message_icon`),
  ADD KEY `id_user` (`id_user_icon`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id_message`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emoji`
--
ALTER TABLE `emoji`
  MODIFY `id_emoji` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `message`
--
ALTER TABLE `message`
  MODIFY `id_message` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=382;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `emoji`
--
ALTER TABLE `emoji`
  ADD CONSTRAINT `emoji_ibfk_1` FOREIGN KEY (`id_message_icon`) REFERENCES `message` (`id_message`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `emoji_ibfk_2` FOREIGN KEY (`id_user_icon`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Constraints for table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
