scope:
	@[ -d .vscode ] && mkdir -p .vscode;
	@[ -f .vscode/settings.json ] && touch .vscode/settings.json;
	@[ -f scope.txt ] && echo 'Colorized auditing scope' || { echo 'The file scope.txt is empty' ; touch scope.txt; exit 1; }
	@inScope='';
	@while read -r line; do \
		inScope="$$inScope \n\t{ \"path\": \"$$line\", \"symbol\": \"AS\", \"tooltip\": \"Auditing Scope\" },"; \
	done < scope.txt; \
	inScope=$$(echo $$inScope | sed 's/,$$//'); \
	currentSetting=$$(cat .vscode/settings.json); \
	currentSetting=$$(echo $$currentSetting | sed 's/^{//' | sed 's/}$$//'); \
	currentSetting=$$(echo $$currentSetting | sed 's/,$$//'); \
	echo { $$currentSetting, \"folder-path-color.folders\": [$$inScope\\n] } | jq > .vscode/settings.json

