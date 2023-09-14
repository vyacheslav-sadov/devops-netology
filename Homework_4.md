Хэш коммита: aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Message: Update CHANGELOG.md

Какому тегу соответствует коммит 85024d3?
Ответ: v0.12.23
Использована команда: git show 85024d3

Сколько родителей у коммита b8d720? Напишите их хеши.
Ответ: 1 родитель, хэш: 56cd7859e05c36c06b56d013b55a252d0bb7e158
Использована команда: git show b8d720^

Перечислите хеши и комментарии всех коммитов, которые были сделаны между тегами v0.12.23 и v0.12.24?
33ff1c03bb960b332be3af2e333462dde88b279e v0.12.24
b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links
3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md
6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable
5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location
06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.mdUpdate CHANGELOG.md
d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows
4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md
dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md
225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release
85024d3100126de36331c6982bfaac02cdab9e76 v0.12.23
 
Использована команда: git log --oneline v0.12.23..v0.12.24, а затем git show <hash commit>

Найдите коммит, в котором была создана функция func providerSource, её определение в коде выглядит так: func providerSource(...) /
(вместо троеточия перечислены аргументы).
Ответ: 5af1e6234ab6da412fb8637393c5a17a1b293663
Использована команда: git grep 'func providerSource' и git log -L :func providerSource:provider_source.go

Найдите все коммиты, в которых была изменена функция globalPluginDirs.
Ответ: 78b12205587fe839f10d946ea3fdc06719decb05, 52dbf94834cb970b510f2fba853a5b49ad9b1a46
Использована команда: git grep "globalPluginDirs" и git log -L :globalPluginDirs:plugins.go

Кто автор функции synchronizedWriters?
Ответ: Author: Martin Atkins <mart@degeneration.co.uk>
Использована команда: git log -S 'func synchronizedWriters' --pretty=oneline и git show <hash commit>