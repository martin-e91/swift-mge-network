# Delete docs folder.
rm -rf docs

# Generate documentation.
swift-doc generate Sources/MGENetwork --output docs --module-name MGENetwork --format html --base-url ./docs
