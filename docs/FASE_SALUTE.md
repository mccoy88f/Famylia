# Modulo Salute

**Stato:** implementato (MVP)

## Contenuto

| Sottosezione | Tipo `HealthEntryType` | Campi principali |
|--------------|------------------------|------------------|
| Visite mediche | `medicalVisit` | medico/struttura, luogo, data |
| Diete | `diet` | obiettivo, calorie target, note (stato `active`) |
| Sport | `sportActivity` | attività, durata, intensità, data sessione |

## Backend

- Modelli: `HealthEntry`, enum `HealthEntryType`, `HealthEntryStatus`, `SportIntensity`
- Endpoint: `health` — `createEntry`, `listEntries`, `upcoming`, `updateEntry`, `completeEntry`, `deleteEntry`

## App

- Route: `/health`
- Schermata con tab Visite | Diete | Sport
- Accesso da Home → chip **Salute**

## Integrazioni

- **Home:** card «Prossime visite» (30 giorni)
- **Diete → Pasti:** pulsante piano pasti + API `applyDietToMealPlan`
- **Aspetto:** colore accento famiglia (`Family.accentColor`) in Impostazioni → Aspetto

## Migration

```bash
cd server && dart run bin/main.dart --apply-migrations
```
