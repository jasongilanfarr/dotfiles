module.exports =

  config:
    preview:
      type: 'string'
      default: 'The Quick brown fox { 0 !== "O" }'
    fontFamily:
      description: 'Use one of the fonts available in this package.'
      type: 'string'
      default: 'Source Code Pro'
      enum: [
        '3270'
        'Anka/Coder'
        'Anonymous Pro'
        'Aurulent Sans Mono'
        'Average Mono'
        'BPmono'
        'Bitstream Vera Sans Mono'
        'CamingoCode'
        'Code New Roman'
        'Consolamono'
        'Cousine'
        'Cutive Mono'
        'DejaVu Mono'
        'Droid Sans Mono'
        'Effects Eighty'
        'Fantasque Sans Mono'
        'Fifteen'
        'Fira Mono'
        'FiraCode'
        'FiraCode Light'
        'Fixedsys Excelsior'
        'Fixedsys Ligatures'
        'GNU Freefont'
        'GNU Unifont'
        'Generic Mono'
        'Gohufont 11'
        'Gohufont 14'
        'Hack'
        'Hasklig'
        'Hermit Light'
        'Hermit'
        'Inconsolata'
        'Inconsolata-g'
        'Iosevka'
        'Iosevka Thin'
        'Iosevka Light'
        'Iosevka Extra Light'
        'Iosevka Medium'
        'Latin Modern Mono Light'
        'Latin Modern Mono'
        'Lekton'
        'Liberation Mono'
        'Luxi Mono'
        'M+ Light'
        'M+ Medium'
        'M+ Thin'
        'M+'
        'Meslo'
        'Monofur'
        'Monoid'
        'Mononoki'
        'NotCourierSans'
        'Nova Mono'
        'Office Code Pro'
        'Office Code Pro Light'
        'Office Code Pro Medium'
        'Oxygen Mono'
        'PT Mono'
        'Profont'
        'Proggy Clean'
        'Quinze'
        'Roboto Mono'
        'Roboto Mono Light'
        'Roboto Mono Thin'
        'Roboto Mono Medium'
        'Share Tech Mono'
        'SK Modernist'
        'Source Code Pro Extra Light'
        'Source Code Pro Light'
        'Source Code Pro Medium'
        'Source Code Pro'
        'Sudo'
        'TeX Gyre Cursor'
        'Ubuntu Mono'
        'VT323'
        'Verily Serif Mono'
        'saxMono'
      ]

  activate: (state) ->

    # code in separate file so deferral keeps activation time down
    atom.packages.onDidActivateInitialPackages ->
      Runner = require './runner'
      Runner.run()