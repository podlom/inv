<div class="bwrap">
	<nav class="navbar row mb-2">
		<h1 class="h4"><a href="/admin/mail/mailing">Рассылка</a>: <span>{$mailing->getName()}</span></h1>
	</nav>

	<div class="card border-0 bg-t">
		<div id="mailing" class="card-body">
			
			<section class="mb-4">
				<h3 class="h5">
					Импорт списка рассылки
					<span class="subheader">CSV <i class="fa fa-file-excel-o" aria-hidden="true"></i></span>
				</h3>
				<div class="import">
					<form method="POST" enctype="multipart/form-data" action="{$controller->url('recipients.import', ['next'=>$controller->url('recipient.index')])}">

						<div class="input-group">
							<div class="custom-file">
								<input type="file" class="custom-file-input" name="file" id="inputcsvfile" required accept=".csv"/>
								<input type="hidden" name="MAX_FILE_SIZE" value="2000000"/>
								<label class="custom-file-label" for="inputcsvfile" aria-describedby="inputcsvfile">Файл не выбран</label>
							</div>
							<div class="input-group-append">
								<button class="btn btn-main" type="submit"><i class="fa fa-cloud-upload" aria-hidden="true"></i> Загрузить</button>
							</div>
						</div>

						<div class="input-group">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="clear" checked id="clearCheck">
								<label class="form-check-label" for="clearCheck">Удалить существующих получателей</label>
							</div>
						</div>
					</form>
				</div>
				
				<!-- div class="py-3">
					или <a class="btn-link" href="{$controller->url('recipients.import_users')}">Загрузить всех пользователей</a>
				</div -->
			</section>

			<section class="mb-4">
				<h3 class="h5">Категория рассылки</h3>
				<select onchange="changeMailLinkHrefVal()" name="mailing_category" id="mail_cat">
					<option value="newsletter">Рассылка инвесторам</option>
					<option value="digest">Дайджест (русский)</option>
					<option value="digest">Дайджест (английский)</option>
				</select>
			</section>

			<section class="mb-5">
				<h3 class="h5">Редактировать E-Mail <span class="subheader">шаблон</span></h3>
				<div>
					<a id="edit_mail_tpl" class="btn btn-main" href="/admin/template/edit/Mail.mailing_{$mailing->getId()}?back={$request->getPathInfo()}"><i class="fa fa-file-text-o" aria-hidden="true"></i> Перейти в редактор шаблона</a>
				</div>
			</section>

			<section class="mb-5">
				<h3 class="h5">Просмотр E-Mail <span class="subheader">шаблона</span></h3>
				<div>
					<a id="preview_mail_tpl" class="btn btn-main" target="_blank" href="/email-preview.php?id={$mailing->getId()}"><i class="fa fa-file-text-o" aria-hidden="true"></i> Перейти к предварительному просмотру шаблона</a>
				</div>
			</section>

			<section class="mb-4">
				<h3 class="h5">
					Отправка писем
					<small class="text-muted">({$stats.0} получателей ждут отправку)</small>
				</h3>

				{react 'Mail.Mailer' props=['stats'=>$stats, 'url'=>$controller->url('mailing.send')]}
				{$statuses = ['Не отправлено', 'Отправлено', 'Ошибка', 'Открыто']}
			</section>

			<section>
				<h3 class="h5">Список рассылки: <a href="{$mailing->getId()}/add?backUrl=/admin/mail/mailing/{$mailing->getId()}" style="float: right; font-size: 16px; font-weight: 400"><i class="fa fa-plus" aria-hidden="true"></i> Добавить получателя</a></h3>
				<div class="table-responsive">
					<table class="table table-borderless table-list table-hover konkurs-list">
						<thead class="table-dark">
							<tr class="bg-info">
								<th scope="col">Email</th>
								<th scope="col">Имя</th>
								<th scope="col" class="text-center">Статус</th>
								<th scope="col" class="text-center">Просмотры</th>
								<th scope="col" class="list-controls text-right">Управление</th>
							</tr>
						</thead>

						{foreach $items as $item}
						<tr>
							<td>{$item->getEmail()}</td>
							<td>{$item->getName()}</td>
							<td class="text-center">{$statuses[$item->getStatus() - 1]}</td>
							<td class="text-center">{$item->getViews()}</td>
							<td class="list-controls text-right">
								<div class="btn-group btn-group-sm ">
									<a data-toggle="tooltip" data-placement="top" title="Отправить"
									class="btn btn-link" href="{$controller->url('recipient.send', ['id'=>$item->getId()])}"><i class="fa fa-paper-plane" aria-hidden="true"></i></a>

									<a data-toggle="tooltip" data-placement="top" title="Редактировать"
									class="btn btn-link" href="{$controller->url('recipient.edit', ['id'=>$item->getId()])}?backUrl=/admin/mail/mailing/{$mailing->getId()}"><i class="fa fa-pencil" aria-hidden="true"></i></a>

									<a data-toggle="tooltip" data-placement="top" title="Удалить" class="btn btn-link" data-href="{$controller->url('recipient.remove', ['id'=>$item->getId()])}"
									   onclick="removeItem(this);" data-original-title="Удалить"><i class="fa fa-remove" aria-hidden="true"></i></a>

								</div>
							</td>
						</tr>
						{/foreach}
					</table>
				</div>
			</section>
		</div>

		<script>
			function removeItem(e) {
				if (confirm('Вы действительно хотите удалить получателя?')) {
					window.location.href = e.dataset.href;
				}
			}

			function changeMailLinkHrefVal() {
				var b1 = "/admin/template/edit/Mail.mailing_{$mailing->getId()}?back={$request->getPathInfo()}";
				var v1 = document.getElementById("mail_cat").value;
				document.getElementById("edit_mail_tpl").href = b1 + "&copy_tpl=" + v1;
			}

			setTimeout(function(){
				changeMailLinkHrefVal();

				$("ul.list-group li").last().attr('style', 'display: none !important');
			}, 1753);
		</script>

	</div>

	<div class="admin-pages">
	   <div class="table-foot">
		   {$items->getPagination()->addClass('pagination')}
	   </div>
	</div>

</div>
