{
  xdg.configFile."pipewire/pipewire.conf.d/99-phase-inverter.conf".text = ''
    context.modules = [
        { name = libpipewire-module-filter-chain
            args = {
                node.description = "Áudio interno Estéreo analógico (Fase Invertida)"
                media.name = "Áudio interno Estéreo analógico (Fase Invertida)"

                filter.graph = {
                    nodes = [
                        {
                            type  = builtin
                            name  = copyFL
                            label = copy
                        }
                        {
                            type   = ladspa
                            name   = invertFR
                            # O Nix substitui isso pelo caminho real do plugin no sistema:
                            plugin = "inv_1429"
                            label  = inv
                        }
                    ]

                    inputs = [
                        "copyFL:In"
                        "invertFR:Input"
                    ]

                    outputs = [
                        "copyFL:Out"
                        "invertFR:Output"
                    ]
                }

                capture.props = {
                    node.name      = "fase_corrigida_input"
                    media.class    = "Audio/Sink"
                    audio.position = [ FL FR ]
                }

                playback.props = {
                    node.name         = "fase_corrigida_output"
                    audio.position    = [ FL FR ]
                    stream.dont-remix = true
                    node.passive      = true
                }
            }
        }
    ]
  '';

}
