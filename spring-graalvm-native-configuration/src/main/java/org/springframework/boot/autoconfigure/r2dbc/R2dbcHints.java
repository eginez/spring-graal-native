/*
 * Copyright 2020 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.springframework.boot.autoconfigure.r2dbc;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import org.springframework.graalvm.extension.NativeImageConfiguration;
import org.springframework.graalvm.extension.NativeImageHint;
import org.springframework.graalvm.extension.TypeInfo;
import org.springframework.graalvm.type.AccessBits;

@NativeImageHint(trigger=R2dbcAutoConfiguration.class, typeInfos= {
		@TypeInfo(typeNames = {
				// TODO review org.springframework.data.r2dbc.dialect.DialectResolver - there is some 
				// factory loading in there.
				"org.springframework.data.r2dbc.dialect.DialectResolver$BuiltInDialectProvider"
		}, types = {
				// Can't find it now but there was some form of wrapper list in R2DBC that listed this plus others
				Mono.class,
				Flux.class
		}, access = AccessBits.DECLARED_CONSTRUCTORS)
})
public class R2dbcHints implements NativeImageConfiguration {
}
