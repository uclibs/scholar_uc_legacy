# Batch import idea

* Put the Works in a location accessible to the server
* The Works to be uploaded in a batch are all in one folder, and are called a Batch.
* Each Work is a folder containing the files the metadata
* The metadata is is a yaml, and represents the data as expected by Curate (any metadata manipulation or mapping is out of scope for this solution), including the relative file location and any other data needed to properly ingest the Work (such as CurationConcern type); see example below.
* From an web-based dashboard, the Repository administrator will browse/connect to the root of the Batch and start a process which will enqueue an ImportWorker for each Work.
* The ImportWorker will parse the yaml and create a work using the application, e.g. `Article.create(parsed_params)`
* ImportWorker status can be monitored from the web-based dashboard

```yaml
curation_concern_type: Article
files: ["./example_file_1.pdf", "./example_file_2.jpg"]
depositor: "repository_manager@uc.edu"
edit_users: "end_user@uc.edu"
visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
metadata:
  title: "Example title"
  creator: ["User 1", "User 2"]
  abstract: "Example abstract"
```

Linking to a similar discussion/implementation in Rake, discussed here: https://groups.google.com/forum/#!topic/hydra-tech/McjynVMunfI