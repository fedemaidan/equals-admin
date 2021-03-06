<?php
namespace AppBundle\Traits;


trait DatosContactoPersonalTrait 
{
	

/**
     * @var string
     *
     * @ORM\Column(name="contactoNombre1", type="string", length=255, nullable=true)
     */
    private $contactoNombre1;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoTelefono1", type="string", length=255, nullable=true)
     */
    private $contactoTelefono1;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoMail1", type="string", length=255, nullable=true)
     */
    private $contactoMail1;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoNombre2", type="string", length=255, nullable=true)
     */
    private $contactoNombre2;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoTelefono2", type="string", length=255, nullable=true)
     */
    private $contactoTelefono2;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoMail2", type="string", length=255, nullable=true)
     */
    private $contactoMail2;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoNombre3", type="string", length=255, nullable=true)
     */
    private $contactoNombre3;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoTelefono3", type="string", length=255, nullable=true)
     */
    private $contactoTelefono3;

    /**
     * @var string
     *
     * @ORM\Column(name="contactoMail3", type="string", length=255, nullable=true)
     */
    private $contactoMail3;


    /**
     * Set contactoTelefono1
     *
     * @param string $contactoTelefono1
     *
     * @return Proveedor
     */
    public function setContactoTelefono1($contactoTelefono1)
    {
        $this->contactoTelefono1 = $contactoTelefono1;

        return $this;
    }

    /**
     * Get contactoTelefono1
     *
     * @return string
     */
    public function getContactoTelefono1()
    {
        return $this->contactoTelefono1;
    }

    /**
     * Set contactoMail1
     *
     * @param string $contactoMail1
     *
     * @return Proveedor
     */
    public function setContactoMail1($contactoMail1)
    {
        $this->contactoMail1 = $contactoMail1;

        return $this;
    }

    /**
     * Get contactoMail1
     *
     * @return string
     */
    public function getContactoMail1()
    {
        return $this->contactoMail1;
    }

    /**
     * Set contactoTelefono2
     *
     * @param string $contactoTelefono2
     *
     * @return Proveedor
     */
    public function setContactoTelefono2($contactoTelefono2)
    {
        $this->contactoTelefono2 = $contactoTelefono2;

        return $this;
    }

    /**
     * Get contactoTelefono2
     *
     * @return string
     */
    public function getContactoTelefono2()
    {
        return $this->contactoTelefono2;
    }

    /**
     * Set contactoMail2
     *
     * @param string $contactoMail2
     *
     * @return Proveedor
     */
    public function setContactoMail2($contactoMail2)
    {
        $this->contactoMail2 = $contactoMail2;

        return $this;
    }

    /**
     * Get contactoMail2
     *
     * @return string
     */
    public function getContactoMail2()
    {
        return $this->contactoMail2;
    }

    /**
     * Set contactoTelefono3
     *
     * @param string $contactoTelefono3
     *
     * @return Proveedor
     */
    public function setContactoTelefono3($contactoTelefono3)
    {
        $this->contactoTelefono3 = $contactoTelefono3;

        return $this;
    }

    /**
     * Get contactoTelefono3
     *
     * @return string
     */
    public function getContactoTelefono3()
    {
        return $this->contactoTelefono3;
    }

    /**
     * Set contactoMail3
     *
     * @param string $contactoMail3
     *
     * @return Proveedor
     */
    public function setContactoMail3($contactoMail3)
    {
        $this->contactoMail3 = $contactoMail3;

        return $this;
    }

    /**
     * Get contactoMail3
     *
     * @return string
     */
    public function getContactoMail3()
    {
        return $this->contactoMail3;
    }

    /**
     * Set contactoNombre1
     *
     * @param string $contactoNombre1
     *
     * @return Proveedor
     */
    public function setContactoNombre1($contactoNombre1)
    {
        $this->contactoNombre1 = $contactoNombre1;

        return $this;
    }

    /**
     * Get contactoNombre1
     *
     * @return string
     */
    public function getContactoNombre1()
    {
        return $this->contactoNombre1;
    }

    /**
     * Set contactoNombre2
     *
     * @param string $contactoNombre2
     *
     * @return Proveedor
     */
    public function setContactoNombre2($contactoNombre2)
    {
        $this->contactoNombre2 = $contactoNombre2;

        return $this;
    }

    /**
     * Get contactoNombre2
     *
     * @return string
     */
    public function getContactoNombre2()
    {
        return $this->contactoNombre2;
    }

    /**
     * Set contactoNombre3
     *
     * @param string $contactoNombre3
     *
     * @return Proveedor
     */
    public function setContactoNombre3($contactoNombre3)
    {
        $this->contactoNombre3 = $contactoNombre3;

        return $this;
    }

    /**
     * Get contactoNombre3
     *
     * @return string
     */
    public function getContactoNombre3()
    {
        return $this->contactoNombre3;
    }

}

