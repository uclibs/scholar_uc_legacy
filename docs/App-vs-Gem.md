A review of features implemented in the App which overrides or overlaps functionality from the Curate Gem:

* Shibboleth login for devise - required additional development to build on devise, plus changes to fields managed by Curate (such as adding additional fields to profiles). Recommendation: extract the expansion on devise into a seperate gem to support UC shibboleth integration with Devise across multiple future apps, and move the other profile changes to the gem.

* Search configuration - this is set by the `config/search_config.yml` file, which is absent in the gem, and which was added by a generator. Ideally, this code would live in the gem to make it easier to build and test search features (because the metadata that gets added to Solr is managed solely within the gem), but it's not a problem to maintain it in the App (we just need to remember to maintain it (and related search specs) for changes in search behavior). Recommendation: keep as is and document.

* Static pages and navigation - these are all implemented in the App as overrides to the Curate gem. Because of this, developers see different layouts when working in the Gem, compared to working in the App. Features such as meta text are largely under the domain of the Gem, and may be overridden within the App.  Another practical concern is that when we move to using the End-to-End spec to test the App, we'll need to do more work to maintain dual versions of this spec. This also isolates the static pages from the layouts used within Curate, which has contributed to some design problems in the current App, and some inconsistency in the implementation of some help information (e.g., welcome pages vs creators' rights) . Recommendation: move the static pages and navigation layout changes to the gem.

* Color and other branding - We learned about Stanford's approach to implementing branding via a gem: https://github.com/sul-dlss/sul_styles. Following this practice now will make life easier later. Recommendation: model our implementation of branding after this approach.

* Contact form and recaptcha - Ideally this could move to the gem, but it is a very narrow, and is not likely to cause any development collisions. Recommendation: keep as is and document.

* Curation Concern things - we've added some overrides for various form partials. Recommendation: move to the Gem.

## What's Left?

* Home page - the landing page, with the slider and other PR features, has no bearing on the rest of the app.
* Deployment configuration work - obviously important to implement in the App. We should examine and document any overrides.