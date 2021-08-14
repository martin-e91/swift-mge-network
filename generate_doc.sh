# Delete docs folder.
rm -rf docs

# Generate documentation.
swift-doc generate Sources/MGENetwork --output Documentation --module-name MGENetwork --format html --base-url "./Documentation"
