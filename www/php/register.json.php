<?php
/*****************************************************************************/
/* Meta-server which registers game servers                                  */
/* Copyright (C) 2002-2016 Christian Mauduit                                 */
/*                                                                           */
/* This program is free software; you can redistribute it and/or modify      */
/* it under the terms of the GNU General Public License as published by      */
/* the Free Software Foundation; either version 2 of the License, or         */
/* (at your option) any later version.                                       */
/*                                                                           */
/* This program is distributed in the hope that it will be useful,           */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             */
/* GNU General Public License for more details.                              */
/*                                                                           */
/* You should have received a copy of the GNU General Public License         */
/* along with this program; if not, write to the Free Software               */
/* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA */
/*                                                                           */
/* Homepage       : http://www.ufoot.org                                     */
/* Contact author : ufoot@ufoot.org                                          */
/*****************************************************************************/

// system page called by servers to register themselves

require 'db.php';
require 'html.php';
require 'metaserver.php';

header("Content-Type: text/plain");

$result=metaserver_register($_GET["protocol"],
$_GET["game"],
$_GET["version"],
$_GET["port"],
$_GET["busy_players"],
$_GET["max_players"],
$_GET["password"],
$_GET["comment"]);

if ($result) {
    echo "1\n";
}
else {
    echo "0\n";
}

?>
