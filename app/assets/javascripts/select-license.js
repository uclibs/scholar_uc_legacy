var ls = function() {
      $('<a href="#" class="btn btn-success selector">License Wizard</a>')
      .prependTo('#license-wizard')
      .licenseSelector({
        // Options

        start: 'DataCopyrightable',

        // Define custom licenses

        licenses: {
          'all-rights-reserved': {
            name: 'All rights reserved',
            priority: 1,
            available: true,
            url: 'http://www.europeana.eu/portal/rights/rr-r.html',
            description: '\"All rights reserved\" is a phrase that originated in copyright law as a formal requirement for copyright notice. It indicates that the copyright holder reserves, or holds for their own use, all the rights provided by copyright law under one specific copyright treaty.',
            categories: ['reserved', 'by', 'nd', 'nc'],
            labels: ['reserved'],
          },
          'cc-by-3': {
            name: 'Attribution 3.0 United States (CC-BY)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by/3.0/us/',
            description: 'This is the standard creative commons license that gives others maximum freedom to do what they want with your work.',
            categories: ['public', 'data', 'by'],
            labels: ['cc', 'by', 'opendata']
          },
          'cc-by-sa-3': {
            name: 'Attribution-ShareAlike 3.0 United States (CC-BY-SA)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by-sa/3.0/us/',
            description: 'This creative commons license is very similar to the regular Attribution license, but requires you to release all derivative works under this same license.',
            categories: ['public', 'data', 'by', 'sa'],
            labels: ['cc', 'by', 'sa', 'opendata'],

          }, 
          'cc-by-nc-3': {
            name: 'Attribution-NonCommercial 3.0 United States (CC-BY-NC)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by-nc/3.0/us/',
            description: 'A creative commons license that bans commercial use.',
            categories: ['public', 'data', 'by', 'nc'],
            labels: ['cc', 'nc'],
          },
          'cc-by-nd-3': {
            name: 'Attribution-NoDerivs 3.0 United States (CC-BY-ND)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by-nd/3.0/us/',
            description: 'The no derivatives creative commons license is straightforward; you can take a work released under this license and re-distribute it but you cannot change it.',
            categories: ['public', 'data', 'by', 'nd'],
            labels: ['cc', 'nd']
          },

          'cc-by-nc-nd-3': {
            name: 'Attribution-NonCommercial-NoDerivs 3.0 United States (CC-BY-NC-ND)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by-nc-nd/3.0/us/',
            description: 'The most restrictive creative commons license. This only allows people to download and share your work for no commercial gain and for no other purposes.',
            categories: ['public', 'data', 'by', 'nc', 'nd'],
            labels: ['cc', 'by', 'nc', 'nd'],
          },

          'cc-by-nc-sa-3': {
            name: 'Attribution-NonCommercial-ShareAlike 3.0 United States (CC-BY-NC-SA)',
            priority: 1,
            available: true,
            url: 'http://creativecommons.org/licenses/by-nc-sa/3.0/us/',
            description: 'A creative commons license that bans commercial use and requires you to release any modified works under this license.',
            categories: ['public', 'data', 'by', 'nc', 'sa'],
            labels: ['cc', 'by', 'nc', 'sa'],
          },

          // Remove default licenses from plugin (most are cc-4.0 and software oriented)

          'cc-zero': {name: 'CC0 1.0 Universal', labels: ['pd']},
          'cc-public-domain': {name: 'Public Domain Mark 1.0', labels: ['pd','']},
          'cc-by': {available: false},
          'cc-by-nc': {available: false},
          'cc-by-nd': {available: false},
          'cc-by-sa': {available: false},
          'cc-by-nc-nd': {available: false},
          'cc-by-nc-sa': {available: false},
          'perl-artistic-1': {available: false},
          'perl-artistic-2': {available: false},
          'gpl-2': {available: false},
          'gpl-2+': {available: false},
          'gpl-3': {available: false},
          'agpl-3': {available: false},
          'epl-1': {available: false},
          'cddl-1': {available: false},
          'lgpl-2.1+': {available: false},
          'lgpl-3': {available: false},
          'mpl-2': {available: false},
          'mit': {available: false},
          'apache-2': {available: false},
          'bsd-2c': {available: false},
          'bsd-3c': {available: false},

        },
            onLicenseSelected : function (license) {
              var license_uri = license.url;
              $('body').scrollTop( scrollTop );
              $('.rights-selector option[value="' + license_uri + '"]').prop('selected', true);
              $('.rights-selector').effect( 'highlight',{color: '#ADD8E6'}, 1500 );
            }
          })
        .on('click', function() { scrollTop = $('body').scrollTop();})
        }
  $(document).on('turbolinks:load', ls);
  