--[[
	Mod Sfinv_menu para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicializador de variaveis e scripts
  ]]

-- Notificador de Inicializador
local notificar = function(msg)
	if minetest.setting_get("log_mods") then
		minetest.debug("[Sfinv_menu]"..msg)
	end
end

local modpath = minetest.get_modpath("sfinv_menu")

-- Variavel global
sfinv_menu = {}

-- Carregar scripts
notificar("Carregando scripts...")

dofile(modpath.."/tradutor.lua")

-- API
dofile(modpath.."/api.lua")

notificar("OK")

