# V4 measured results — supplemental reconstructed prototype

**This section must NOT be described as validation of the undocumented historical measurements.**

Experimental conditions: five *simulated logical clients*, ten deterministic *local mock* tools, five repeated call/initialization trials per architecture. All three arms completed 250/250 calls. Arms: reusable direct adapter, non-MCP gateway, and official Python MCP SDK over stdio.

| Architecture | NIP (analytic) | Mean local coupling (Q) | Mean method cohesion (Q) | Integration NLOC |
|---|---:|---:|---:|---:|
| Traditional | 50 | 1.00 (1) | 10.00 (1) | 12 |
| Non-MCP gateway | 15 | 1.00 (1) | 10.00 (1) | 16 |
| Official MCP SDK | 15 | 1.50 (2) | 8.33 (2) | 82 |

Five API contract-change scenarios were evaluated for the Traditional and MCP arms (not for the gateway arm). Mean number of modified integration source files: Traditional 1.00; MCP 1.00. See the [per-scenario results](experiments/contract_mutation/ripple_actual_changes.csv) and [patches](experiments/contract_mutation/patches/).

**Operationalization and limits:** CBO is a count of distinct locally coupled Python integration modules per source module, *not CKJM class-level CBO*. Cohm is the manuscript's custom 0–10 share of related method pairs based on shared self attributes or the same imported local helper; not a validated standard Python cohesion metric. The denominator Q is explicitly different for the traditional and MCP arms, and the source modules were not randomly sampled. Five timing repetitions do not provide five independent CBO/Cohm observations. Ripple units are intentionally introduced contract changes, not randomized independent production events. The common local mock implementation is used by all architectures; code footprint excludes shared provider code and must not be called the original LOIC measure. NIP and reachability are properties of the specified topology. Direct and gateway code run in-process, MCP runs over stdio, so timing is not a fair controlled performance comparison.

**Interpretation:** A non-MCP gateway achieves the same *analytical NIP* as MCP in this model. The reconstructed results do not reproduce a universal MCP advantage in coupling, cohesion, or ripple effect. The article's original figures should be archived as unverified historical claims, not be presented as experimentally validated. Additional experiments with real LLM inference, genuine tool APIs, and stronger alternative architectures would be necessary before generalizing these findings.
