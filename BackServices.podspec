Pod::Spec.new do |spec|

  spec.name         = "BackServices"
  spec.version      = "0.0.1"
  spec.summary      = "Framework desarrollado para la app MovieApp."

  spec.description  = <<-DESC
                    Framework para el desarrollo de aplicación movil de componentes, servicios, manejadores.
                   DESC

  spec.homepage     = "https://github.com/JosPerez/BackServices"
  spec.license      = "Prueba Tecnica 2022"
  spec.author    = "JosPerez"
  spec.platform     = :ios, "13.0"
  spec.swift_version = '5.0'
  spec.source       = { :git => "https://github.com/JosPerez/BackServices.git", :branch => "main" }
  spec.source_files  = "BackServices/BackServices/**/*.{swift}"
  spec.requires_arc = true
end
