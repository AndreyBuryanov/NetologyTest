
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
    // СтандартныеПодсистемы.ПодключаемыеКоманды
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
    // Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
    ПодключаемыеКомандыКлиент.ПослеЗаписи(ЭтотОбъект, Объект, ПараметрыЗаписи);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТовары

&НаКлиенте
Процедура ТоварыКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура ТоварыПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

&НаКлиенте
Процедура ТоварыСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Товары.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыУслуги

&НаКлиенте
Процедура УслугиКоличествоПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиЦенаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиСкидкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Услуги.ТекущиеДанные;
	
	РассчитатьСуммуСтроки(ТекущиеДанные);
	
КонецПроцедуры

&НаКлиенте
Процедура УслугиПриИзменении(Элемент)
	РассчитатьСуммуДокумента();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура РассчитатьСуммуСтроки(ТекущиеДанные)
	
	//++ Бурьянов 28.02.2024. Изменено при обновлении на версию 1.0.1.2
	//КоэффициентСкидки = 1 - ТекущиеДанные.Скидка / 100;
	КоэффициентСкидки = 1 - (ТекущиеДанные.Скидка + Объект.Д_СогласованнаяСкидка) / 100;
	Если КоэффициентСкидки < 0 Тогда
		КоэффициентСкидки = 0;
		Сообщить(СтрШаблон("Сумма скидки по позиции ""%1"" превысила 100%% с учетом общей скидки по документу",
			ТекущиеДанные.Номенклатура));
	КонецЕсли;
	//-- Бурьянов 28.02.2024
	
	ТекущиеДанные.Сумма = ТекущиеДанные.Цена * ТекущиеДанные.Количество * КоэффициентСкидки;
	
КонецПроцедуры

&НаКлиенте
Процедура Д_ПересчитатьСуммы(Команда)
	Д_ПересчитатьСуммыТабличныхЧастей(); //++ Бурьянов 26.02.2024
КонецПроцедуры

&НаКлиенте
Процедура Д_ПересчитатьСуммыТабличныхЧастей()
	//++ Бурьянов 26.02.2024
    Д_ПересчитатьСуммыТабличнойЧасти(Объект.Товары);
	Д_ПересчитатьСуммыТабличнойЧасти(Объект.Услуги);
	//-- Бурьянов 26.02.2024
КонецПроцедуры

&НаКлиенте
Процедура Д_ПересчитатьСуммыТабличнойЧасти(ТабличнаяЧасть)
	//++ Бурьянов 26.02.2024
	Если ТабличнаяЧасть.Количество() = 0 Тогда
		Возврат;		
	КонецЕсли;
	//-- Бурьянов 26.02.2024
	
	//++ Бурьянов 28.02.2024. Изменено при обновлении на версию 1.0.1.2
	Для каждого ТекСтрока Из ТабличнаяЧасть Цикл
		РассчитатьСуммуСтроки(ТекСтрока); 
	КонецЦикла;
	//-- Бурьянов 28.02.2024
КонецПроцедуры

&НаКлиенте
Процедура Д_СогласованнаяСкидкаПриИзменении(Элемент)
	
	Д_ОбработатьИзменениеСкидкиАсинхронно();//++ Бурьянов 26.02.2024
КонецПроцедуры

&НаКлиенте
Асинх Процедура Д_ОбработатьИзменениеСкидкиАсинхронно()
	//++ Бурьянов 26.02.2024
	Если Объект.Товары.Количество() = 0 И Объект.Услуги.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Ответ = Ждать ВопросАсинх("Пересчитать суммы в таблицах товаров и услуг?", РежимДиалогаВопрос.ДаНет);
	Если Ответ = КодВозвратаДиалога.Да Тогда
		Д_ПересчитатьСуммыТабличныхЧастей();
	КонецЕсли;
	//-- Бурьянов 26.02.2024
КонецПроцедуры

&НаКлиенте
Процедура РассчитатьСуммуДокумента()
	
	Объект.СуммаДокумента = Объект.Товары.Итог("Сумма") + Объект.Услуги.Итог("Сумма");
	
КонецПроцедуры

#Область ПодключаемыеКоманды

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
    ПодключаемыеКомандыКлиент.НачатьВыполнениеКоманды(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьВыполнениеКомандыНаСервере(ПараметрыВыполнения, ДополнительныеПараметры) Экспорт
    ВыполнитьКомандуНаСервере(ПараметрыВыполнения);
КонецПроцедуры

&НаСервере
Процедура ВыполнитьКомандуНаСервере(ПараметрыВыполнения)
    ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, ПараметрыВыполнения, Объект);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
    ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

#КонецОбласти

#КонецОбласти
