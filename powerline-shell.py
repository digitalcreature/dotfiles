add_set_term_title_segment(powerline)
add_virtual_env_segment(powerline)
add_ssh_segment(powerline)
add_cwd_segment(powerline)
add_read_only_segment(powerline)
add_git_segment(powerline)
add_hg_segment(powerline)
add_svn_segment(powerline)
add_fossil_segment(powerline)
add_exit_code_segment(powerline)
sys.stdout.write(powerline.draw())