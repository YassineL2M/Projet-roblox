--[[
	╔═══════════════════════════════════════════════════════════════════════════╗
	║  CINEMATIC SABER LOOK                                                     ║
	║  Lighting + Atmosphere + Post-Effects + aide visuelle sabres              ║
	║  Prêt à coller dans Roblox Studio                                         ║
	╚═══════════════════════════════════════════════════════════════════════════╝

	── INSTALLATION (30 secondes) ─────────────────────────────────────────────
	1) Dans Studio : sélectionne "Lighting" → dans Properties, mets
	   Technology = Future, puis ShadowSoftness = 0.35
	   (le script ne peut PAS changer Technology : c'est verrouillé au runtime)

	2) Explorer → ServerScriptService → clic droit → Insert Object → Script
	   Nomme-le "CinematicSaberLook", puis colle TOUT ce fichier dedans.

	3) Enregistre et teste. C'est tout.

	── ASTUCE : l'appliquer en 1 clic (et le sauvegarder dans le place) ──────
	Colle le contenu de ce fichier dans la BARRE DE COMMANDE de Studio
	(View → Command Bar), choisis ton preset, Entrée.
	Les changements sont alors dans le .rbxl et n'ont même plus besoin du script.

	── LES 3 PRESETS ────────────────────────────────────────────────────────
	  "GOLDEN" → fin d'après-midi doré, arène de pierre. C'est le preset qui
	             correspond à ta capture d'écran (le plus proche de ton aperçu).
	  "NIGHT"  → duel de nuit, sabres qui éclairent tout. Rendu le plus
	             cinématique, idéal pour les miniatures 7 et 8.
	  "NEON"   → arène sombre + néons, très saturé, style "esport".

	── RÉGLAGES À TOUCHER EN PREMIER ────────────────────────────────────────
	  • Look "trop clair"          → baisse Lighting.Brightness (dans le preset)
	  • Sabres qui ne "claquent" pas → monte Bloom.Intensity (0.9 → 1.4)
	  • Trop contrasté / écrasé    → baisse ColorCorrection.Contrast
	  • Image trop orange/bleue    → change ColorCorrection.TintColor
	  • Ciel : remplace les lignes SKY_BK / SKY_DN / etc. par ton propre
	    skybox (IDs rbxassetid://...). Laisse vide = ciel Roblox par défaut.
--]]

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

-- ═══════════════════════════════════════════════════════════════════════════
--  1. CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════════════

local PRESET                 = "GOLDEN"  -- "GOLDEN" | "NIGHT" | "NEON"
local APPLY_SABER_HELPERS    = true      -- halo des lames + traînée de swing
local OPTIMIZE_LAMPS         = true      -- sécurise les lampadaires (perf)

local SKY_BK, SKY_DN, SKY_FT, SKY_LF, SKY_RT, SKY_UP = "", "", "", "", "", ""
-- ↑ laisse vide = ciel Roblox par défaut. Sinon : "rbxassetid://123456"

-- ═══════════════════════════════════════════════════════════════════════════
--  2. PRESETS
-- ═══════════════════════════════════════════════════════════════════════════

local PRESETS = {

	-- Fin d'après-midi doré sur une arène de pierre (≈ ta capture d'écran)
	GOLDEN = {
		Lighting = {
			ClockTime               = 16.6,
			GeographicLatitude      = 14,
			Brightness              = 2.1,
			Ambient                 = Color3.fromRGB(58, 52, 48),
			OutdoorAmbient          = Color3.fromRGB(126, 122, 118),
			ExposureCompensation    = 0.12,
			EnvironmentDiffuseScale = 0.45,
			EnvironmentSpecularScale= 0.75,
			ShadowSoftness          = 0.35,
			GlobalShadows           = true,
			FogEnd                  = 100000,
			FogColor                = Color3.fromRGB(196, 176, 148),
		},
		Atmosphere = {
			Density = 0.30, Offset = 0.10, Glare = 0.38, Haze = 1.7,
			Color   = Color3.fromRGB(214, 196, 168),
			Decay   = Color3.fromRGB(120, 104, 88),
		},
		Sky = { SunAngularSize = 18, MoonAngularSize = 12, StarCount = 3000, CelestialBodiesShown = true },
		Post = {
			Bloom         = { Intensity = 0.95, Size = 32, Threshold = 0.92 },
			ColorCorrection = { Contrast = 0.13, Saturation = 0.10, Brightness = 0.00,
			                    TintColor = Color3.fromRGB(255, 247, 232) },
			SunRays       = { Intensity = 0.085, Spread = 0.92 },
			DepthOfField  = { FarIntensity = 0.08, FocusDistance = 38, InFocusRadius = 30, NearIntensity = 0.08 },
		},
	},

	-- Duel de nuit : seuls les sabres éclairent la scène
	NIGHT = {
		Lighting = {
			ClockTime               = 0.35,
			GeographicLatitude      = 20,
			Brightness              = 0.85,
			Ambient                 = Color3.fromRGB(18, 20, 32),
			OutdoorAmbient          = Color3.fromRGB(34, 40, 62),
			ExposureCompensation    = 0.25,
			EnvironmentDiffuseScale = 0.60,
			EnvironmentSpecularScale= 0.90,
			ShadowSoftness          = 0.45,
			GlobalShadows           = true,
			FogEnd                  = 100000,
			FogColor                = Color3.fromRGB(16, 20, 34),
		},
		Atmosphere = {
			Density = 0.38, Offset = 0.05, Glare = 0.15, Haze = 2.3,
			Color   = Color3.fromRGB(28, 34, 56),
			Decay   = Color3.fromRGB(12, 14, 26),
		},
		Sky = { SunAngularSize = 8, MoonAngularSize = 22, StarCount = 8000, CelestialBodiesShown = true },
		Post = {
			Bloom         = { Intensity = 1.35, Size = 40, Threshold = 0.78 },
			ColorCorrection = { Contrast = 0.18, Saturation = 0.05, Brightness = -0.02,
			                    TintColor = Color3.fromRGB(214, 226, 255) },
			SunRays       = { Intensity = 0.035, Spread = 0.8 },
			DepthOfField  = { FarIntensity = 0.12, FocusDistance = 30, InFocusRadius = 26, NearIntensity = 0.12 },
		},
	},

	-- Arène sombre saturée, style esport / néon
	NEON = {
		Lighting = {
			ClockTime               = 1.2,
			GeographicLatitude      = 0,
			Brightness              = 1.0,
			Ambient                 = Color3.fromRGB(30, 22, 52),
			OutdoorAmbient          = Color3.fromRGB(44, 36, 78),
			ExposureCompensation    = 0.30,
			EnvironmentDiffuseScale = 0.55,
			EnvironmentSpecularScale= 1.00,
			ShadowSoftness          = 0.30,
			GlobalShadows           = true,
			FogEnd                  = 100000,
			FogColor                = Color3.fromRGB(24, 18, 46),
		},
		Atmosphere = {
			Density = 0.34, Offset = 0.20, Glare = 0.45, Haze = 1.9,
			Color   = Color3.fromRGB(58, 44, 96),
			Decay   = Color3.fromRGB(20, 14, 42),
		},
		Sky = { SunAngularSize = 4, MoonAngularSize = 4, StarCount = 4000, CelestialBodiesShown = false },
		Post = {
			Bloom         = { Intensity = 1.15, Size = 36, Threshold = 0.82 },
			ColorCorrection = { Contrast = 0.20, Saturation = 0.28, Brightness = 0.00,
			                    TintColor = Color3.fromRGB(226, 214, 255) },
			SunRays       = { Intensity = 0.02, Spread = 0.7 },
			DepthOfField  = { FarIntensity = 0.10, FocusDistance = 34, InFocusRadius = 28, NearIntensity = 0.10 },
		},
	},
}

local preset = PRESETS[PRESET] or PRESETS.GOLDEN

-- ═══════════════════════════════════════════════════════════════════════════
--  3. OUTILS INTERNES
-- ═══════════════════════════════════════════════════════════════════════════

local TAG = "CinematicSaberLook"  -- marque nos instances pour pouvoir les remplacer

-- Supprime uniquement CE QUE CE SCRIPT A CRÉÉ (jamais tes propres effets)
local function clearOurEffects()
	for _, child in ipairs(Lighting:GetChildren()) do
		if child:GetAttribute(TAG) then
			child:Destroy()
		end
	end
end

-- Propriétés qu'on tente sans jamais râler (verrouillées hors Studio, etc.)
local SILENT_PROPS = { Technology = true }

-- Assigne des propriétés sans jamais planter si l'une n'existe pas / est verrouillée
local function setProps(instance, props, quiet)
	for key, value in pairs(props) do
		local ok = pcall(function() instance[key] = value end)
		if not ok and not quiet and not SILENT_PROPS[key] then
			warn(("[CinematicSaberLook] Impossible de régler %s.%s"):format(instance.ClassName, key))
		end
	end
end

local function newEffect(className, props, parent)
	local fx = Instance.new(className)
	setProps(fx, props or {})
	fx:SetAttribute(TAG, true)
	fx.Parent = parent or Lighting
	return fx
end

local function getOrCreateSky()
	local existing = Lighting:FindFirstChildOfClass("Sky")
	if existing then return existing end
	local sky = Instance.new("Sky")
	-- Volontairement NON taggé : ton Sky personnalisé n'est jamais supprimé par ce script
	sky.Parent = Lighting
	return sky
end

-- ═══════════════════════════════════════════════════════════════════════════
--  4. APPLICATION
-- ═══════════════════════════════════════════════════════════════════════════

local function applyPreset()
	clearOurEffects()

	-- Technologie : verrouillée en runtime, on tente seulement en Studio (sans warn)
	if RunService:IsStudio() then
		pcall(function() Lighting.Technology = Enum.Technology.Future end)
	end

	setProps(Lighting, preset.Lighting)

	-- Atmosphere : on RÉUTILISE celle du jeu si elle existe (on ne la supprime pas)
	local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
	if not atmosphere then
		atmosphere = Instance.new("Atmosphere")
		atmosphere.Parent = Lighting
	end
	setProps(atmosphere, preset.Atmosphere, true)

	-- Ciel
	local sky = getOrCreateSky()
	setProps(sky, preset.Sky)
	if SKY_BK ~= "" then
		setProps(sky, { SkyboxBk = SKY_BK, SkyboxDn = SKY_DN, SkyboxFt = SKY_FT,
		                SkyboxLf = SKY_LF, SkyboxRt = SKY_RT, SkyboxUp = SKY_UP })
	end

	-- Post-effects
	local post = preset.Post
	newEffect("BloomEffect", post.Bloom)
	newEffect("ColorCorrectionEffect", post.ColorCorrection)
	newEffect("SunRaysEffect", post.SunRays)
	newEffect("DepthOfFieldEffect", post.DepthOfField)

	print(("[CinematicSaberLook] Preset '%s' appliqué."):format(PRESET))
end

-- ─── Optimisation des lampadaires (important : tu en as beaucoup) ──────────
local function optimizeLamps()
	local lights = 0
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("PointLight") or obj:IsA("SpotLight") then
			lights += 1
			obj.Shadows = false                      -- le plus gros gain de perf
			if obj.Range > 30 then obj.Range = 26 end
			if obj.Brightness > 2 then obj.Brightness = 2 end
		end
	end
	if lights > 60 then
		warn(("[CinematicSaberLook] %d lumières détectées. Au-delà de ~60, "
			.. "prévois un système qui n'active que les lampes proches du joueur."):format(lights))
	else
		print(("[CinematicSaberLook] %d lumières sécurisées."):format(lights))
	end
end

-- ═══════════════════════════════════════════════════════════════════════════
--  5. AIDE VISUELLE SABRES (cœur néon + halo + traînée de swing)
-- ═══════════════════════════════════════════════════════════════════════════
--  démarre TOUT seul sur n'importe quelle Tool/Part dont le nom contient
--  "saber", "blade" ou "lame" — sinon appelle decorateBlade(part, couleur)
-- ═══════════════════════════════════════════════════════════════════════════

local SaberVisuals = {}

local function guessAxis(part)
	local s = part.Size
	if s.Z >= s.Y and s.Z >= s.X then return Vector3.new(0, 0, 1), s.Z end
	if s.Y >= s.X then return Vector3.new(0, 1, 0), s.Y end
	return Vector3.new(1, 0, 0), s.X
end

-- Renvoie la couleur actuelle de la lame (ou un bleu par défaut)
local function bladeColor(part)
	if part.Color ~= Color3.new(1, 1, 1) then return part.Color end
	return Color3.fromRGB(90, 190, 255)
end

function SaberVisuals.decorateBlade(part, color)
	if not part or not part:IsA("BasePart") then return end
	if part:FindFirstChild("CSL_Halo") then return end -- déjà décorée

	color = color or bladeColor(part)

	-- 1) La lame doit être un Neon pur (sinon elle n'"émet" pas)
	part.Material = Enum.Material.Neon
	part.CastShadow = false

	-- 2) Halo lumineux qui éclaire vraiment le sol et les murs
	local light = Instance.new("PointLight")
	light.Name = "CSL_Halo"
	light.Color = color
	light.Brightness = 2.6
	light.Range = 15
	light.Shadows = false
	light.Parent = part

	-- 3) Traînée de swing (Trail entre la base et la pointe de la lame)
	local axis, length = guessAxis(part)

	local a0 = Instance.new("Attachment")
	a0.Name = "CSL_Base"
	a0.Position = -axis * (length * 0.5)

	local a1 = Instance.new("Attachment")
	a1.Name = "CSL_Tip"
	a1.Position = axis * (length * 0.5)

	a0.Parent = part
	a1.Parent = part

	local trail = Instance.new("Trail")
	trail.Attachment0 = a0
	trail.Attachment1 = a1
	trail.Lifetime = 0.22
	trail.MinLength = 0.1
	trail.FaceCamera = true
	trail.LightEmission = 1        -- la traînée s'ajoute à la lumière au lieu de l'assombrir
	trail.LightInfluence = 0       -- et ignore l'éclairage ambiant → rendu néon
	trail.WidthScale = NumberSequence.new(0.85, 0.15)  -- plus large près de la garde
	trail.Color = ColorSequence.new(color:Lerp(Color3.new(1, 1, 1), 0.35), color)
	trail.Transparency = NumberSequence.new(0.15, 0.95)
	trail.Parent = part
end

local function autoDecorate()
	local function tryDecorate(inst)
		if inst:IsA("BasePart") and inst:FindFirstChild("CSL_Halo") == nil then
			local n = inst.Name:lower()
			if n:find("saber") or n:find("blade") or n:find("lame") or n:find("kyber") then
				SaberVisuals.decorateBlade(inst)
			end
		end
	end

	for _, inst in ipairs(workspace:GetDescendants()) do
		tryDecorate(inst)
	end

	workspace.DescendantAdded:Connect(function(inst)
		if inst:IsA("BasePart") then
			task.defer(tryDecorate, inst)
		end
	end)
end

-- ═══════════════════════════════════════════════════════════════════════════
--  6. EXÉCUTION
-- ═══════════════════════════════════════════════════════════════════════════

applyPreset()
if OPTIMIZE_LAMPS then optimizeLamps() end
if APPLY_SABER_HELPERS then autoDecorate() end

-- API globale, utilisable depuis la barre de commande ou un autre script :
--   _G.CinematicSaberLook.setPreset("NIGHT")
--   _G.CinematicSaberLook.saber(maPartDeLame, Color3.fromRGB(255, 60, 60))
_G.CinematicSaberLook = {
	setPreset = function(name)
		if PRESETS[name] then
			PRESET = name
			preset = PRESETS[name]
			applyPreset()
			return true
		end
		warn("[CinematicSaberLook] Preset inconnu : " .. tostring(name))
		return false
	end,
	saber = SaberVisuals.decorateBlade,
	optimizeLamps = optimizeLamps,
}
