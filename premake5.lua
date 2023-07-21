workspace "Bird-flight"
	configurations { "Debug", "Release" }
	architecture "x86_64"
	
	outputdir = "%{cfg.buildcfg}-%{cfg.architecture}"
	targetdir ("%{wks.location}/bin/" .. outputdir)
	objdir ("%{wks.location}/temp/" .. outputdir)
  

	IncludeDir = {}
	IncludeDir["SDL2"] = "%{wks.location}/external/SDL2/include"
	IncludeDir["SDL2_image"] = "%{wks.location}/external/SDL2_image/include"

	LibDir = {}
	LibDir["SDL2"] = "%{wks.location}/external/SDL2/lib"
	LibDir["SDL2_image"] = "%{wks.location}/external/SDL2_image/lib"

	project "Bird-flight"
		kind "ConsoleApp"
		language "C++"
		cppdialect "C++17"
		staticruntime "on"
		files
		{
			"src/**.h",
			"src/**.hpp",
			"src/**.c",
			"src/**.cpp",
			"include/**.h",
			"include/**.hpp",
			"include/**.c",
			"include/**.cpp",
		}
		
		links
		{
			"SDL2",
			"SDL2main",
			"SDL2_image",
		}

		libdirs
		{
			"%{LibDir.SDL2}",
			"%{LibDir.SDL2_image}",
		}

		includedirs
		{
			"src",
			"%{IncludeDir.SDL2}",
			"%{IncludeDir.SDL2_image}",
		}

--		{
--			"{COPY} %{LibDir.SDL2}/SDL2.dll %{cfg.targetdir}",
--			"{COPY} %{LibDir.SDL2_image}/SDL2_image.dll %{cfg.targetdir}",
--			"{COPY} %{wks.location}/data %{cfg.targetdir}/data"
--		}

		filter "configurations:Debug"
		  defines { "DEBUG" }
		  runtime "Debug"
		  symbols "On"
		  kind ("ConsoleApp")

	   filter "configurations:Release"
		  defines { "RELEASE" }
		  runtime "Release"
		  symbols "Off"
		  optimize "On"
		  kind ("WindowedApp")