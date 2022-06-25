rm -rf docs-out/.git;
rm -rf docs-out/main;
for tag in $(echo "main"; git tag);
do
  echo "⏳ Generating documentation for "$tag" release.";

  if [ -d "docs-out/$tag" ]
  then
      echo "✅ Documentation for "$tag" already exists.";
  else
      git checkout "$tag";
      mkdir -p Sources/MGENetwork/Documentation.docc;
      export DOCC_HTML_DIR="$(pwd)/swift-docc-render/dist";
      rm -rf .build/symbol-graphs;
      mkdir -p .build/symbol-graphs;
      swift build -Xswiftc "-sdk" -Xswiftc "`xcrun --sdk iphonesimulator --show-sdk-path`" -Xswiftc "-target" -Xswiftc "x86_64-apple-ios13.0-simulator" \
        --target MGENetwork \
        -Xswiftc \
        -emit-symbol-graph \
        -Xswiftc \
        -emit-symbol-graph-dir \
        -Xswiftc \
        .build/symbol-graphs \
        && swift-docc/.build/release/docc convert Sources/MGENetwork/Documentation.docc \
          --fallback-display-name MGENetwork \
          --fallback-bundle-identifier co.pointfree.MGENetwork \
          --fallback-bundle-version 0.0.0 \
          --additional-symbol-graph-dir \
          .build/symbol-graphs \
          --transform-for-static-hosting \
          --hosting-base-path /swift-MGENetwork/"$tag" \
          --output-path docs-out/"$tag" \
          && echo "✅ Documentation generated for "$tag" release." \
          || echo "⚠️ Documentation skipped for "$tag".";
  fi;
done
