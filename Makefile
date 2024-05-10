scope:
	@[ -d `pwd`/.vscode ] || mkdir -p `pwd`/.vscode; \
	[ -f `pwd`/.vscode/settings.json ] || touch `pwd`/.vscode/settings.json; \
	[ -f `pwd`/scope.txt ] && echo 'Colorized auditing scope' || { echo 'The file scope.txt is empty' ; touch scope.txt; exit 1; }; \
	inScope=''; while read -r line; do \
		inScope="$$inScope \n\t{ \"path\": \"$$line\", \"symbol\": \"AS\", \"tooltip\": \"Auditing Scope\", \"color\": \"blue\" },"; \
		echo $$line; \
	done < `pwd`/scope.txt; \
	inScope=$$(echo $$inScope | sed 's/,$$//'); \
	currentSetting=$$(cat `pwd`/.vscode/settings.json); \
	[ -n "$$currentSetting" ] && currentSetting=','; \
	currentSetting=$$(echo $$currentSetting | sed 's/^{//' | sed 's/}$$//'); \
	currentSetting=$$(echo $$currentSetting | sed 's/,$$//'); \
	echo { $$currentSetting \"folder-path-color.folders\": [$$inScope\\n] } | jq > `pwd`/.vscode/settings.json

