--[[
	Mod Sfinv_menu para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	API
  ]]

-- Tradutor de Strings
local S = sfinv_menu.S

-- Lista de botoes registrados
sfinv_menu.botoes_registrados = {}

-- Numero de registros
sfinv_menu.n_botoes_registrados = 0

-- Registra aba no sfinv (caso o mod seja usado)
local aba_sfinv_criada = false

-- Botoes de formspec
local botoes_formspec = {
	{"image[0,0;1,1;", "]button[1,0;3,1;", ";", "]"},
	{"image[0,1;1,1;", "]button[1,1;3,1;", ";", "]"},
	{"image[0,2;1,1;", "]button[1,2;3,1;", ";", "]"},
	{"image[0,3;1,1;", "]button[1,3;3,1;", ";", "]"},
	{"image[4,0;1,1;", "]button[5,0;3,1;", ";", "]"},
	{"image[4,1;1,1;", "]button[5,1;3,1;", ";", "]"},
	{"image[4,2;1,1;", "]button[5,2;3,1;", ";", "]"},
	{"image[4,3;1,1;", "]button[5,3;3,1;", ";", "]"}
}

-- Registrar botão
--[[
	def = {
		titulo = "Titulo", -- Titulo exibido no botao
		icon = "image.png", -- imagem quadrada
		privs = {}, -- Privilegios requeridos
		func = function(player) end, -- função executada quando o botao é clicado
	}
  ]]
sfinv_menu.registrar_botao = function(id, def)
	
	
	-- Verifica se ja atingiu limite de botoes
	if sfinv_menu.n_botoes_registrados + 1 > 8 then
		minetest.log("error", "[Sfinv_menu] Erro ao registrar botao '"..id.."'. Limite de 8 botoes excedido")
		local i = 1
		for idd,def in pairs(sfinv_menu.botoes_registrados) do
			minetest.log("error", i.." - "..idd)
			i = i + 1
		end
		return false
	end
	
	sfinv_menu.botoes_registrados[id] = def
	sfinv_menu.n_botoes_registrados = sfinv_menu.n_botoes_registrados + 1
	
	-- Verifica se ja registrou a aba
	if aba_sfinv_criada == false then
		aba_sfinv_criada = true
		
		sfinv.register_page("sfinv_menu:conf", {
			title = S("Mais"),
			get = function(self, player, context)
				
				-- Lista de botoes
				local formspec = ""
				local i = 1
				for id,def in pairs(sfinv_menu.botoes_registrados) do
					-- verifica se tem privilegios
					if minetest.check_player_privs(player:get_player_name(), def.privs or {}) == true then
						local f = botoes_formspec[i]
						formspec = formspec .. f[1] .. def.icon .. f[2] .. id .. f[3] .. def.titulo .. f[4]
						i = i + 1
					end
				end
				
				return sfinv.make_formspec(player, context, 
					formspec
					.."listring[current_player;main]"
					.."listring[current_player;craft]"
					.."image[0,4.75;1,1;gui_hb_bg.png]"
					.."image[1,4.75;1,1;gui_hb_bg.png]"
					.."image[2,4.75;1,1;gui_hb_bg.png]"
					.."image[3,4.75;1,1;gui_hb_bg.png]"
					.."image[4,4.75;1,1;gui_hb_bg.png]"
					.."image[5,4.75;1,1;gui_hb_bg.png]"
					.."image[6,4.75;1,1;gui_hb_bg.png]"
					.."image[7,4.75;1,1;gui_hb_bg.png]", 
				true)
			end,
			on_player_receive_fields = function(self, player, context, fields)
				for f,d in pairs(fields) do
					if sfinv_menu.botoes_registrados[f] then
						sfinv_menu.botoes_registrados[f].func(player)
						return
					end
				end
			end,
		})
	end
	
	return true
end


