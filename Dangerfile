not_declared_trivial = !(github.pr_title.include? "#trivial")
has_source_changes = !git.modified_files.grep(/Source/).empty?

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

# Changelog entries are required for changes to library files
no_changelog_entry = !git.modified_files.include?("CHANGELOG.md")
if has_source_changes && no_changelog_entry && not_declared_trivial && git.lines_of_code > 10
  fail("Any source code changes should have an entry in CHANGELOG.md.")
end

# Milestones are required to track what's included in each release
if has_source_changes && not_declared_trivial
  has_milestone = !github.pr_json['milestone'].nil?
  warn('All pull requests should have a milestone attached, unless marked *#trivial*.', sticky: false) unless has_milestone
end

# Docs are regenerated when releasing
has_doc_changes = !git.modified_files.grep(/docs\//).empty?
has_doc_gen_title = github.pr_title.include? "#docgen"
if has_doc_changes && !has_doc_gen_title
  fail("Docs are regenerated when creating new releases.")
  message("Docs are generated by using [Jazzy](https://github.com/realm/jazzy). If you want to contribute, please update [markdown guides](https://github.com/Instagram/IGListKit/tree/main/Guides)")
end

# Warn if Source files were added or removed but examples are not updated
added_source_files = !git.added_files.grep(/Source/).empty?
deleted_source_files = !git.deleted_files.grep(/Source/).empty?
ios_pods_not_updated = !git.modified_files.include?("Examples/Examples-iOS/Podfile.lock")
macos_pods_not_updated = !git.modified_files.include?("Examples/Examples-macOS/Podfile.lock")
tvos_pods_not_updated = !git.modified_files.include?("Examples/Examples-tvOS/Podfile.lock")
if (added_source_files || deleted_source_files) && (ios_pods_not_updated || macos_pods_not_updated || tvos_pods_not_updated)
  warn("Adding or removing library source files requires updating the examples. Please run `./scripts/pod_setup.sh` from the root directory and commit the changes.")
end

swiftlint.verbose = true
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files(inline_mode: true)
